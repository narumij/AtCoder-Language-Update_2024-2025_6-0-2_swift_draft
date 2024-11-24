#!/bin/sh

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.2
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"

cp test/main.swift Sources/main.swift

./${SWIFT_TAR_BALL}/usr/bin/swift \
    build \
    -c release \
    1>&2

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF

cp test/abc235_d/main.1.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
./${SWIFT_TAR_BALL}/usr/bin/swift \
    build \
    -c release \
    1>&2
time .build/release/Main < test/abc235_d/sample-x.in

cp test/abc235_d/main.2.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
./${SWIFT_TAR_BALL}/usr/bin/swift \
    build \
    -c release \
    1>&2
.build/release/Main < test/abc235_d/sample-x.in
time .build/release/Main < test/abc235_d/sample-x.in
