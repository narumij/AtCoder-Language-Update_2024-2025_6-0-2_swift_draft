#!/usr/bin/env python3
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time

root = Path(__file__).resolve().parents[1]
prefix = Path(sys.argv[1]).resolve()
compiler = prefix / 'compile.py'
env = dict(os.environ, SWIFT_BACKTRACE='enable=no')
with tempfile.TemporaryDirectory(prefix='swift-submissions-') as temporary:
    work = Path(temporary)
    executable = work / 'main'
    def compile(source, success=True, extra=()):
        start = time.monotonic()
        result = subprocess.run([sys.executable, str(compiler), str(source), str(executable), *extra],
                                cwd=work, env=env, capture_output=True, text=True, timeout=120)
        print(f'compile {source.name}: {time.monotonic() - start:.2f}s', flush=True)
        if (result.returncode == 0) != success:
            raise AssertionError(result.stdout + result.stderr)
        if not success:
            assert not executable.exists(), 'A failed compilation left a stale executable'
    def run(expected, input=''):
        result = subprocess.run([str(executable)], input=input, capture_output=True, text=True,
                                cwd=work, env=env, timeout=30)
        assert result.returncode == 0, result.stderr
        assert result.stdout.strip() == expected.strip(), repr(result.stdout)
    source = work / 'main.swift'
    source.write_text('print("first")\n')
    compile(source)
    run('first')
    compile(root / 'test/prebuilt/main.swift')
    run('ok')
    compile(root / 'test/macro/main.swift')
    run('Hello, Swift Macros\nTak 20 10 0 is 20\n102334155')
    compile(root / 'test/mainActor/main.swift')
    run('Hello, MainActor!\nIs Main Thread: true\nHello, MainActor Again!\nIs Main Thread: true')
    compile(root / 'test/stdio/main.swift')
    result = subprocess.run([str(executable)], capture_output=True, text=True, env=env, timeout=30)
    assert result.returncode == 0 and result.stdout.strip() == '1 2 3', result
    assert result.stderr.strip() == 'Hello, STDERR!', result.stderr
    for number in (1, 2):
        compile(root / f'test/abc235_d/main.{number}.swift')
        run((root / 'test/abc235_d/sample-x.out').read_text(), (root / 'test/abc235_d/sample-x.in').read_text())
    compile(root / 'test/compileError/main.swift', success=False)
    source.write_text('let i = Int(readLine()!)!\nprint([1, 2, 3][i])\n')
    compile(source)
    result = subprocess.run([str(executable)], input='9\n', capture_output=True, text=True, env=env, timeout=30)
    assert result.returncode != 0, 'Out-of-range access did not fail'
    source.write_text('@main struct Main { static func main() { print("entry") } }\n')
    compile(source, extra=('-parse-as-library',))
    run('entry')
    source.write_text('print("last")\n')
    compile(source)
    run('last')
print('All prebuilt submission checks passed', flush=True)
