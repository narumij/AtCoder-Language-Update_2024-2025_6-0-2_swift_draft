#!/bin/sh

cat << 'EOF' > Sources/main.swift
import Foundation
import Collections
import Algorithms
import Numerics
import IntegerUtilities
import AtCoder
import AcFoundation
import AcCollections
import Numerics
import BigInt
import BigNum
import SwiftGraph

let N = Int.stdin
let A = [Int].stdin(columns: N)

print(N)
print(A)

var s = RedBlackTreeSet<Int>(A)

print(s.contains(3) ? "Yes" : "No")

print(gcd(12, 16))

typealias modint = modint998244353

print(modint(12))

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

# export PATH=/usr/local/swift/usr/bin:$PATH
./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift build -c release --swift-sdk x86_64-swift-linux-musl 1>&2

ls -al .build/release/Main
ls -al .build/x86_64-swift-linux-musl/release/Main

cat << 'EOF' | ./.build/release/Main
3
1 2 3
EOF

# .build/x86_64-swift-linux-musl/release/Main

#swift run --configuration release Main
