#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
prefix=$(cd "$(dirname "$0")" && pwd -P)
source "$prefix/config.sh"
input=$1
output=$2
shift 2
rm -f -- "$output"
command=("$swiftc" -swift-version 6 -default-isolation nonisolated -O -whole-module-optimization
  -DONLINE_JUDGE -I "$prefix/modules" -L "$prefix/lib" -lJudgeLibraries)
for module_map in "$prefix/include/"*/module.modulemap; do
  include=$(dirname "$module_map")
  command+=(-Xcc "-fmodule-map-file=$module_map")
  case $(basename "$include") in
    CBLAS|CLAPACK) ;;
    *) command+=(-Xcc "-I$include") ;;
  esac
done
for plugin in "$prefix/plugins/"*Macros-tool; do
  module=$(basename "$plugin" -tool)
  command+=(-load-plugin-executable "$plugin#${module//-/_}")
done
command+=("${link_flags[@]}" "$@" "$input" -o "$output")
export LD_LIBRARY_PATH="$prefix/plugins${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
if "${command[@]}"; then
  exit 0
else
  status=$?
  rm -f -- "$output"
  exit "$status"
fi
