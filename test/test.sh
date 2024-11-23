#!/bin/sh

cat << 'EOF' > Sources/main.swift
import Foundation

#if os(macOS) || os(iOS)
    print("Hello, Apple platform!")
#elseif canImport(Glibc)
    print("Hello, Glibc!")
#elseif canImport(Musl)
    print("Hello, Musl!")
#else
    print("Hello, Anything else!")
#endif
EOF

export PATH=/usr/local/swift/usr/bin:$PATH
swift build release --swift-sdk x86_64-swift-linux-musl 1>&2

./.build/release/Main

#swift run --configuration release Main
