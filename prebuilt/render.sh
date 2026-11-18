#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd -P)
cd "$root"
temporary=$(mktemp)
trap 'rm -f "$temporary"' EXIT
{
  cat dist/language.toml
  printf "filename = 'main.swift'\n\ninstall = '''\n"
  printf '%s\n' 'set -euo pipefail' 'mkdir -p prebuilt/Sources dist'
  for file in prebuilt/Package.swift prebuilt/Sources/Libraries.swift prebuilt/build.sh prebuilt/compile.sh dist/install.sh prebuilt/Package.resolved; do
    if grep -qx 'ATCODER_FILE_EOF' "$file"; then
      echo "Heredoc delimiter found in $file" >&2
      exit 1
    fi
    printf "cat > %s <<'ATCODER_FILE_EOF'\n" "$file"
    cat "$file"
    printf 'ATCODER_FILE_EOF\n'
  done
  printf '%s\n' 'bash dist/install.sh'
  printf "'''\n\ncompile = '''\nbash SwiftLibraries/compile.sh main.swift main\n'''\n\n"
  printf "%s\n" "environment.SWIFT_BACKTRACE = 'enable=yes,output-to=stderr,interactive=no'" \
    '' "object = 'main'" "execution = ['main']"
} > "$temporary"
if [[ ${1:-} == --check ]]; then
  if ! cmp -s "$temporary" dist/swift.toml; then
    echo 'Run bash prebuilt/render.sh to refresh dist/swift.toml' >&2
    exit 1
  fi
else
  cat "$temporary" > dist/swift.toml
fi
