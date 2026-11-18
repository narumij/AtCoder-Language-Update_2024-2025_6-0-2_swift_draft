import AcCollections
import AcFoundation
import AcMemoize
import AccelerateLinux
import Algorithms
import AtCoder
import BigInt
import BigNum
import Collections
import Foundation
import Numerics
import simd

var deque = Deque([1, 2, 3])
precondition(deque.popFirst() == 1)
precondition(Array([1, 2, 3].adjacentPairs()).count == 2)
precondition((Complex<Double>(3, 4) + Complex<Double>(2, 1)).real == 5)
precondition(BigInt("12345678901234567890")! + 1 == BigInt("12345678901234567891")!)
precondition(BigRational(1, 2) + BigRational(1, 2) == BigRational(1))
var set = RedBlackTreeSet<Int>([3, 1, 2])
precondition(set.contains(2))
precondition(modint998244353(2).pow(10).val == 1024)
precondition(SIMD2<Int>(1, 2)[1] == 2)
precondition("123".contains(/[0-9]+/))
precondition(gcd(12, 15) == 3)
print("ok")
