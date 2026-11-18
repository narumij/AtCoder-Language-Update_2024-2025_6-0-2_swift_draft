#!/usr/bin/env python3
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

package = Path(sys.argv[1]).resolve()
prefix = Path(sys.argv[2]).resolve()
swift = str(Path(shutil.which(os.environ.get('SWIFT', 'swift'))).absolute())
env = dict(os.environ, SWIFT_AC_LIBRARY_USES_O_UNCHECKED='true')
base = [swift, 'build', '--build-system', 'native', '--package-path', str(package), '-c', 'release']
subprocess.run(base + ['--product', 'JudgeLibraries', '--disable-automatic-resolution', '--jobs', os.environ.get('BUILD_JOBS', '2')], env=env, check=True)
bin_path = Path(subprocess.check_output(base + ['--show-bin-path'], env=env, text=True).strip())
if prefix.exists():
    raise SystemExit(f'Output already exists: {prefix}')
prefix.mkdir(parents=True)
shutil.copytree(bin_path / 'Modules', prefix / 'modules')
(prefix / 'lib').mkdir()
shutil.copy2(bin_path / 'libJudgeLibraries.a', prefix / 'lib')
checkouts = package / '.build/checkouts'
modules = []
for name, relative in [
    ('_NumericsShims', 'swift-numerics/Sources/_NumericsShims/include'),
    ('_FastIO', 'swift-ac-foundation/Sources/_FastIO/include'),
    ('_MT19937', 'swift-ac-foundation/Sources/_MT19937/include'),
    ('_cxx', 'swift-ac-foundation/Sources/_cxx/include'),
    ('CBLAS', 'accelerate-linux/Sources/CBLAS'),
    ('CLAPACK', 'accelerate-linux/Sources/CLAPACK'),
]:
    source = checkouts / relative
    destination = prefix / 'include' / name
    shutil.copytree(source, destination)
    module_map = source / 'module.modulemap'
    if not module_map.exists():
        module_map = bin_path / f'{name}.build/module.modulemap'
    contents = module_map.read_text()
    contents = contents.replace(str(source), str(destination))
    contents = contents.replace(str(source.resolve()), str(destination))
    (destination / 'module.modulemap').write_text(contents)
    modules.append(name)
plugins = []
for executable in bin_path.glob('*Macros-tool'):
    module = executable.name.removesuffix('-tool').replace('-', '_')
    destination = prefix / 'plugins' / executable.name
    destination.parent.mkdir(exist_ok=True)
    shutil.copy2(executable, destination)
    plugins.append([executable.name, module])
if not plugins:
    raise SystemExit('No macro plugin was built')
for library in bin_path.glob('*.so*'):
    shutil.copy2(library, prefix / 'plugins' / library.name)
licenses = prefix / 'licenses'
for checkout in checkouts.iterdir():
    for source in checkout.glob('*'):
        if source.is_file() and source.name.upper().startswith(('LICENSE', 'COPYING', 'NOTICE')):
            destination = licenses / checkout.name
            destination.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, destination / source.name)
shutil.copy2(package / 'Package.resolved', prefix / 'Package.resolved')
config = {'swiftc': str(Path(swift).with_name('swiftc')), 'modules': modules, 'plugins': plugins,
          'link_flags': ['-I/usr/include/x86_64-linux-gnu', '-I/usr/include/x86_64-linux-gnu/openblas-pthread',
                         '-L/usr/lib/x86_64-linux-gnu', '-L/usr/lib/x86_64-linux-gnu/openblas-pthread',
                         '-llapacke', '-lopenblas', '-lstdc++', '-lm'],
          'swift_version': subprocess.check_output([swift, '--version'], text=True)}
(prefix / 'config.json').write_text(json.dumps(config, indent=2) + '\n')
shutil.copy2(package / 'compile.py', prefix / 'compile.py')
print(f'Installed prebuilt libraries: {prefix}')
