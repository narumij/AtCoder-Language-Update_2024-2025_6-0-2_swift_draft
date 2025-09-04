// 更新成功したら通るはずのコード
import AcCollections
import AcFoundation
import AcMemoize
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
import IOReader
import IOUtil
import MT19937
import Miscellaneous
import Numerics
import Pack
import PermutationModule
import RedBlackTreeModule
import StringUtil
import UInt8Util
import simd

try main()

@MainActor
public func main() throws {

//  let A: [Int] = try [Int].readLine()
    let A: [Int] = [1, 2, 3, 4, 5, 6]
  //  let A: [Int] = [1,1,1,1,1,1]
  var deme: [[[Int]: BigRat]] = [[:]] * 6
  for n in 1..<6 {
    let deno = 6 ** n
    for idxs in (0..<6).product(ofCount: n) {
      deme[n][idxs.sorted(), default: 0] += BigRat(1, deno)
    }
  }

  @Memoize
  func f(_ rest_turn: Int, _ keep_idxs: [Int]) -> BigRat {
    if keep_idxs.count == 5 {
      var count = [Int: Int]()
      for idx in keep_idxs {
        count[A[idx], default: 0] += 1
      }
      return .init(count.map { $0 * $1 }.max()!)
    }
    let rest_dice = 5 - keep_idxs.count
    var ans: BigRat = 0
    for deme_idxs in (0..<6).product(ofCount: rest_dice) {
      let prob: BigRat = .init(1, 6 ** rest_dice)
      var M: BigRat = 0
      let keeps: [Int] = rest_turn != 1 ? (0..<1 << rest_dice) + [] : [(1 << rest_dice) - 1]
      for keep in keeps {
        var new_idxs: [Int] = keep_idxs
        for i in 0..<deme_idxs.count where keep >> i & 1 == 1 {
          new_idxs.append(deme_idxs[i])
        }
        M = max(M, f(rest_turn - 1, new_idxs.sorted()))
      }
      ans += M * prob
    }
    return ans
  }

  print(f(3, []).asDouble)
}

extension Sequence {

  @inlinable
  @inline(never)
  func product(ofCount n: Int) -> [[Element]] {
    if n == 0 { return [[]] }
    let smaller = product(ofCount: n - 1)
    var result: [[Element]] = []
    for prefix in smaller {
      for x in self {
        result.append(prefix + [x])
      }
    }
    return result
  }
}
