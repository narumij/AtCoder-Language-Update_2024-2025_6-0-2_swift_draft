#if false
@preconcurrency import Foundation
import AcCollections
import AcFoundation
import Algorithms
import AtCoder
import BigInt
import Bisect
import Collections
import IOReader
import IOUtil
import Numerics
import PermutationModule
import RedBlackTreeModule
import simd

#if canImport(Glibc)
import AccelerateLinux
#else
import Accelerate
#endif

private typealias DefaultIsolation = Never

func hoge() {
#if os(macOS) || os(iOS)
  print("Hello, Apple platform!")
#elseif canImport(Glibc)
  print("Hello, Glibc!")
#elseif canImport(Musl)
  print("Hello, Musl!")
#else
  print("Hello, Anything else!")
#endif
}

#endif
