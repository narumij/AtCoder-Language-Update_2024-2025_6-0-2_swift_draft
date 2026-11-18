#!/usr/bin/env bash
set -euo pipefail
case ${1:-} in install|compile) ;; *) echo 'Expected install or compile' >&2; exit 1;; esac
awk -v key="$1" '
  BEGIN { quote = sprintf("%c%c%c", 39, 39, 39) }
  $0 == key " = " quote { active = 1; found++; next }
  active && $0 == quote { active = 0; closed++; next }
  active { print }
  END { if (found != 1 || closed != 1 || active) exit 1 }
' "${2:-dist/swift.toml}"
