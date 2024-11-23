#!/bin/sh

cat << 'EOF' > Sources/main.swift
import Foundation

#if os(macOS) || os(iOS)
    print("Hello, Apple platform!")
#elseif canImport(Glibc)
    print("Hello, Glibc!")
#elseif canImport(Musl)
    print("Hello, Musl!")
#endif
EOF

export PATH=/usr/local/swift/usr/bin:$PATH
swift build -Xswiftc -O -Xlinker -lm -c release Main 1>&2

swift run --configuration release Main