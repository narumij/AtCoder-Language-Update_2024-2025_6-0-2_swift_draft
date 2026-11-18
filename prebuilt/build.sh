#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
package=$(cd "$1" && pwd -P)
mkdir -p "$(dirname "$2")"
prefix="$(cd "$(dirname "$2")" && pwd -P)/$(basename "$2")"
if [[ -e "$prefix" ]]; then
  echo "Output already exists: $prefix" >&2
  exit 1
fi
swift=$(command -v "${SWIFT:-swift}")
swift="$(cd "$(dirname "$swift")" && pwd -P)/$(basename "$swift")"
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
base=("$swift" build --build-system native --package-path "$package" -c release)
"${base[@]}" --product JudgeLibraries --disable-automatic-resolution --jobs "${BUILD_JOBS:-2}"
bin_path=$("${base[@]}" --show-bin-path)
mkdir -p "$prefix/modules" "$prefix/lib" "$prefix/include" "$prefix/plugins" "$prefix/licenses"
cp -R "$bin_path/Modules/." "$prefix/modules/"
cp "$bin_path/libJudgeLibraries.a" "$prefix/lib/"
checkouts="$package/.build/checkouts"
while read -r name relative; do
  source_dir=$(cd "$checkouts/$relative" && pwd -P)
  destination="$prefix/include/$name"
  mkdir -p "$destination"
  cp -R "$source_dir/." "$destination/"
  module_map="$source_dir/module.modulemap"
  if [[ ! -f "$module_map" ]]; then
    module_map="$bin_path/$name.build/module.modulemap"
  else
    chmod u+w "$destination/module.modulemap"
  fi
  SOURCE_DIR="$source_dir" DESTINATION="$destination" awk '
    BEGIN { from = ENVIRON["SOURCE_DIR"]; to = ENVIRON["DESTINATION"] }
    { line = $0; result = ""
      while ((pos = index(line, from)) > 0) {
        result = result substr(line, 1, pos - 1) to
        line = substr(line, pos + length(from))
      }
      print result line
    }' "$module_map" > "$destination/module.modulemap"
done <<'MODULES'
_NumericsShims swift-numerics/Sources/_NumericsShims/include
_FastIO swift-ac-foundation/Sources/_FastIO/include
_MT19937 swift-ac-foundation/Sources/_MT19937/include
_cxx swift-ac-foundation/Sources/_cxx/include
CBLAS accelerate-linux/Sources/CBLAS
CLAPACK accelerate-linux/Sources/CLAPACK
MODULES
plugins=("$bin_path/"*Macros-tool)
if [[ ${#plugins[@]} == 0 ]]; then
  echo 'No macro plugin was built' >&2
  exit 1
fi
cp "${plugins[@]}" "$prefix/plugins/"
for library in "$bin_path/"*.so*; do
  cp "$library" "$prefix/plugins/"
done
for checkout in "$checkouts/"*; do
  for file in "$checkout/"[Ll][Ii][Cc][Ee][Nn][Ss][Ee]* "$checkout/"[Cc][Oo][Pp][Yy][Ii][Nn][Gg]* "$checkout/"[Nn][Oo][Tt][Ii][Cc][Ee]*; do
    [[ -f "$file" ]] || continue
    directory="$prefix/licenses/$(basename "$checkout")"
    mkdir -p "$directory"
    cp "$file" "$directory/"
  done
done
cp "$package/Package.resolved" "$prefix/Package.resolved"
{
  printf 'swiftc=%q\n' "$(dirname "$swift")/swiftc"
  printf 'link_flags=('
  printf ' %q' -I/usr/include/x86_64-linux-gnu -I/usr/include/x86_64-linux-gnu/openblas-pthread \
    -L/usr/lib/x86_64-linux-gnu -L/usr/lib/x86_64-linux-gnu/openblas-pthread \
    -llapacke -lopenblas -lstdc++ -lm
  printf ' )\n'
} > "$prefix/config.sh"
"$swift" --version > "$prefix/swift-version.txt"
cp "$package/compile.sh" "$prefix/compile.sh"
echo "Installed prebuilt libraries: $prefix"
