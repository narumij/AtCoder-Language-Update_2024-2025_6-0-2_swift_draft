#!/bin/sh

cp test/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//"              

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF

cp test/abc235_d/main.1.swift Sources/main.swift

# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//"              

time .build/release/Main < test/abc235_d/sample-x.in

cp test/abc235_d/main.2.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean

tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//"              

.build/release/Main < test/abc235_d/sample-x.in
time .build/release/Main < test/abc235_d/sample-x.in
