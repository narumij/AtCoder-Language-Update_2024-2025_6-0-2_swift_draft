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
@preconcurrency import Foundation
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

#if canImport(Glibc)
  import AccelerateLinux
#else
  import Accelerate
#endif

#if ONLINE_JUDGE
// 提出した際に実行される
#else
// ローカル環境で実行される
#endif

@MainActor
public func main() throws {
//  let N: Int = stdin()
  //  let (N, Q): (Int, Int) = stdin()
  //  let (N, M) = (Int.stdin, Int.stdin)
  //  let (H, W) = (Int.stdin, Int.stdin)
  //  let A = [Int].stdin(columns: N)
  //  let S = [Character].stdin
  //  let S = [Character].stdin(columns: N)
  //  let S = [[Character]].stdin(rows: H, columns: W)
  
//  print("Hello, world! (\(N))")
  
  let i = readLine()!.components(separatedBy: " ").compactMap{ Int($0) }
  let (_,L,R) = (i[0],i[1] - 1,i[2] - 1)
  let S = readLine()!
  print((L..<R).allSatisfy{ S[$0] == "o" } ? "Yes" : "No")
}

extension String {

  @inlinable
  @inline(__always)
  public subscript(offset: Int) -> Character {
    self[index(startIndex, offsetBy: offset)]
  }
}

try main()

