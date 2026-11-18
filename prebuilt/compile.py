#!/usr/bin/env python3
import json
import os
from pathlib import Path
import subprocess
import sys

prefix = Path(__file__).resolve().parent
config = json.loads((prefix / 'config.json').read_text())
source = Path(sys.argv[1]).resolve()
output = Path(sys.argv[2]).resolve()
output.unlink(missing_ok=True)
command = [config['swiftc'], '-swift-version', '6', '-default-isolation', 'nonisolated',
           '-O', '-whole-module-optimization', '-DONLINE_JUDGE',
           '-I', str(prefix / 'modules'), '-L', str(prefix / 'lib'), '-lJudgeLibraries']
for module in config['modules']:
    include = prefix / 'include' / module
    command += ['-Xcc', f'-fmodule-map-file={include / "module.modulemap"}']
    if module not in ('CBLAS', 'CLAPACK'):
        command += ['-Xcc', '-I' + str(include)]
for executable, module in config['plugins']:
    command += ['-load-plugin-executable', f'{prefix / "plugins" / executable}#{module}']
command += config['link_flags']
command += sys.argv[3:] + [str(source), '-o', str(output)]
env = dict(os.environ)
env['LD_LIBRARY_PATH'] = str(prefix / 'plugins') + (':' + env['LD_LIBRARY_PATH'] if env.get('LD_LIBRARY_PATH') else '')
result = subprocess.run(command, env=env)
if result.returncode:
    output.unlink(missing_ok=True)
sys.exit(result.returncode)
