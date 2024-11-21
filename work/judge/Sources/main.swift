import Foundation
import AtCoder
import AcFoundation
import AcCollections
import Numerics

let N = Int.stdin
let A = [Int].stdin(columns: N)

print(N)
print(A)

var s = RedBlackTreeSet<Int>(A)

print(s.contains(3) ? "Yes" : "No")
