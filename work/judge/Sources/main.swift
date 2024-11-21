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
