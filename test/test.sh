#!/bin/bash

echo "Heap size: $(ulimit -v)"
echo "Stack size: $(ulimit -s)"

rm .build/release/Main
cp test/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF

rm .build/release/Main
cp test/abc235_d/main.1.swift Sources/main.swift

# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

time .build/release/Main < test/abc235_d/sample-x.in

rm .build/release/Main
cp test/abc235_d/main.2.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

.build/release/Main < test/abc235_d/sample-x.in
time .build/release/Main < test/abc235_d/sample-x.in

export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

rm .build/release/Main
cp test/crash/crash1.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

cp test/crash/crash2.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

rm .build/release/Main
cp test/mainActor/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

rm .build/release/Main
cp test/macro/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
EOF


rm .build/release/Main
cp test/stdio/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.3
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

./${SWIFT_TAR_BALL}/usr/bin/swift build -c release -v > build0.log
sed -i 's/Hello/Hallo/' Sources/main.swift
./${SWIFT_TAR_BALL}/usr/bin/swift build -c release -v > build.log
sed -n '/swiftc/{
    s/ -v / /;
    s/-parseable-output//;
    s/ -j[0-9][0-9]*//g;
    s/ -num-threads [0-9][0-9]*//g;
    p
}' build.log > build.sh

echo '########################'

cat build.log

echo '########################'

cat build.sh

echo '########################'

time bash build.sh

echo '########################'

cat << 'EOF' | .build/release/Main
EOF

echo '########################'

rm .build/release/Main
cp test/main.swift Sources/main.swift

time bash build.sh

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF
