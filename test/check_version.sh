#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
python3 - "${1:-$root/SwiftLibraries}" <<'PY'
import json
from pathlib import Path
import subprocess
import sys
prefix = Path(sys.argv[1])
config = json.loads((prefix / 'config.json').read_text())
current = subprocess.check_output([config['swiftc'], '--version'], text=True)
assert current == config['swift_version'], (current, config['swift_version'])
print(current, end='')
PY
