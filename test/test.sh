#!/bin/sh

echo "Heap size: $(ulimit -v)"
echo "Stack size: $(ulimit -s)"

rm .build/release/Main
cp test/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF

rm .build/release/Main
cp test/abc235_d/main.1.swift Sources/main.swift

# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

time .build/release/Main < test/abc235_d/sample-x.in

rm .build/release/Main
cp test/abc235_d/main.2.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

.build/release/Main < test/abc235_d/sample-x.in
time .build/release/Main < test/abc235_d/sample-x.in

export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

rm .build/release/Main
cp test/crash/crash1.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
EOF

cp test/crash/crash2.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
EOF

rm .build/release/Main
cp test/mainActor/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
EOF

rm .build/release/Main
cp test/macro/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
EOF


rm .build/release/Main
cp test/stdio/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | sh              

cat << 'EOF' | .build/release/Main
EOF

