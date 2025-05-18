import Foundation
import Collections
import Algorithms
import Numerics
import AtCoder
import AcFoundation
import IOReader
import IOUtil
import Bisect
import AcCollections
import RedBlackTreeModule
import PermutationModule
import Numerics
import BigInt
import BigNum
import SwiftGraph
//import AcMemoize
import simd
import AccelerateLinux

let N = Int.stdin
let A = [Int].stdin(columns: N)

print(N)
print(A)

var s = RedBlackTreeSet<Int>(A)

print(s.contains(3) ? "Yes" : "No")

print(gcd(12, 16))

typealias modint = modint998244353

print(modint(12))

print(cos(Double.pi))

#if os(macOS) || os(iOS)
    print("Hello, Apple platform!")
#elseif canImport(Glibc)
    print("Hello, Glibc!")
#elseif canImport(Musl)
    print("Hello, Musl!")
#else
    print("Hello, Anything else!")
#endif

let vec = SIMD2<Int>(1, 2)
print(vec)