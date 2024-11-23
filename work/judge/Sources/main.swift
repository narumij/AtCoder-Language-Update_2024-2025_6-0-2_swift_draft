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

#if false
let N = Int.stdin
let A = [Int].stdin(columns: N)
#endif

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
