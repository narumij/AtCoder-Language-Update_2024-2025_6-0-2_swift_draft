import AcCollections
import AcFoundation
import AccelerateLinux
import Algorithms
import AtCoder
import BigInt
import BigNum
import Bisect
import CharacterUtil
import Collections
import Convenience
import CxxWrapped
import Foundation
import Foundation
import IOReader
import IOUtil
import Miscellaneous
import Numerics
import Pack
import PermutationModule
import RedBlackTreeModule
import UInt8Util
import simd

let N = Int.stdin
let A = [Int].stdin(columns: N)

print(N)
print(A)

var s = RedBlackTreeSet<Int>(A)

print(s.contains(3) ? "Yes" : "No")

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
func hoge() {
    print(vec)
}

hoge()

// 'keyAndValue' is created using a regex literal
let keyAndValue = /(.+?): (.+)/
// 'simpleDigits' is created from a pattern in a string
let simpleDigits = try Regex("[0-9]+")

let setting = "color: 161 103 230"
if setting.contains(simpleDigits) {
    print("'\(setting)' contains some digits.")
}

print("gcd", gcd(12, 15))
print("lcm", lcm(12, 15))

fastPrint(Int.max)