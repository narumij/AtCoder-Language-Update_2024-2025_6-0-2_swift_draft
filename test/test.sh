#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
python3 "$root/test/prebuilt_test.py" "${1:-$root/SwiftLibraries}"
