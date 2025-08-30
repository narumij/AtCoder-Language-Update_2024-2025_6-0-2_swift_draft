import AcCollections
import AcFoundation
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

#if canImport(Glibc)
  import AccelerateLinux
#else
  import Accelerate
#endif

try main()

@MainActor  // MainActorを付与すると最適化が有利になる
public func main() throws {
  
  let N: Int = stdin()

  #if ONLINE_JUDGE
    // 提出時に標準エラーに出力され、解答出力に影響しない
    print("Hello, AtCoder error! (\(N))", to: &FileOutputStream.standardError)
  #else
    // ローカル環境で標準エラーに出力され、解答出力に影響しない
    print("Hello, local error! (\(N))", to: &FileOutputStream.standardError)
  #endif

  // 解答出力の例
  print("Hello, world! (\(N))")
}
