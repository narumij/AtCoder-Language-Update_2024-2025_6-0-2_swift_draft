#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd -P)
prefix=$(cd "${1:-$root/SwiftLibraries}" && pwd -P)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
export SWIFT_BACKTRACE=enable=no
cd "$work"
compile() {
  timeout 120 bash "$prefix/compile.sh" "$1" "$work/main" "${@:2}"
}
run() {
  timeout 30 "$work/main" > actual.out 2> actual.err
  printf '%s\n' "$1" > expected.out
  diff -u expected.out actual.out
}
printf 'print("first")\n' > main.swift
compile main.swift
run first
compile "$root/test/prebuilt/main.swift"
run ok
compile "$root/test/macro/main.swift"
run $'Hello, Swift Macros\nTak 20 10 0 is 20\n102334155'
compile "$root/test/mainActor/main.swift"
run $'Hello, MainActor!\nIs Main Thread: true\nHello, MainActor Again!\nIs Main Thread: true'
compile "$root/test/stdio/main.swift"
run '1 2 3'
printf 'Hello, STDERR!\n' > expected.err
diff -u expected.err actual.err
for number in 1 2; do
  compile "$root/test/abc235_d/main.$number.swift"
  timeout 30 "$work/main" < "$root/test/abc235_d/sample-x.in" > actual.out
  diff -u "$root/test/abc235_d/sample-x.out" actual.out
done
if compile "$root/test/compileError/main.swift"; then
  echo 'Invalid Swift unexpectedly compiled' >&2
  exit 1
fi
[[ ! -e "$work/main" ]]
printf 'let i = Int(readLine()!)!\nprint([1, 2, 3][i])\n' > main.swift
compile main.swift
printf '9\n' > input.txt
if timeout 30 "$work/main" < input.txt > actual.out 2> actual.err; then
  echo 'Out-of-range access did not fail' >&2
  exit 1
else
  status=$?
  if [[ $status == 124 || $status == 125 || $status == 126 || $status == 127 ]]; then
    echo "Runtime check failed to execute or timed out: $status" >&2
    exit 1
  fi
fi
printf '@main struct Main { static func main() { print("entry") } }\n' > main.swift
compile main.swift -parse-as-library
run entry
printf 'print("last")\n' > main.swift
compile main.swift
run last
echo 'All prebuilt submission checks passed'
