#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd -P)
prefix=${1:-$root/SwiftLibraries}
source "$prefix/config.sh"
"$swiftc" --version | diff -u "$prefix/swift-version.txt" -
cat "$prefix/swift-version.txt"
