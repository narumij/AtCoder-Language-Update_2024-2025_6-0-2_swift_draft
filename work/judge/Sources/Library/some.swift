#if false
@preconcurrency import Foundation
import AcFoundation
import AcCollections
import AtCoder
import Algorithms
import BigInt
import Collections
import Numerics
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
