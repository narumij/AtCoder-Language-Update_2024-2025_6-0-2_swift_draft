#!/usr/bin/env python3
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[1]
files = ['prebuilt/Package.swift', 'prebuilt/Sources/Libraries.swift', 'prebuilt/build.py',
         'prebuilt/compile.py', 'dist/install.sh']
if (root / 'prebuilt/Package.resolved').exists():
    files.append('prebuilt/Package.resolved')
install = ['set -euo pipefail', 'mkdir -p prebuilt/Sources dist']
for name in files:
    data = (root / name).read_text()
    marker = 'ATCODER_FILE_EOF'
    assert marker not in data
    install.append(f"cat > {name} <<'{marker}'\n{data.rstrip()}\n{marker}")
install.append('bash dist/install.sh')
text = (root / 'dist/language.toml').read_text()
text += "filename = 'main.swift'\n\ninstall = '''\n" + '\n'.join(install) + "\n'''\n\n"
text += "compile = '''\npython3 SwiftLibraries/compile.py main.swift main\n'''\n\n"
text += "environment.SWIFT_BACKTRACE = 'enable=yes,output-to=stderr,interactive=no'\n\nobject = 'main'\nexecution = ['main']\n"
path = root / 'dist/swift.toml'
if '--check' in sys.argv:
    if path.read_text() != text:
        raise SystemExit('Run python3 prebuilt/render.py to refresh dist/swift.toml')
else:
    path.write_text(text)
