import AcCollections
import AcFoundation
//import AcMemoize
import Algorithms
import AtCoder
import BigInt
import BigNum
import Bisect
import Collections
@preconcurrency import Foundation
import IOReader
import IOUtil
import IntegerUtilities
import Numerics
import PermutationModule
import RedBlackTreeModule
import SwiftGraph
import simd

#if os(macOS) || os(iOS)
  print("Hello, Apple platform!")
#elseif canImport(Glibc)
  print("Hello, Glibc!")
#elseif canImport(Musl)
  print("Hello, Musl!")
#else
  print("Hello, Anything else!")
#endif

print("test", to: &stderr)

//import AcFoundation
//import Collections


import AcFoundation

func Yes(_ flag: Bool) -> String { flag ? "Yes" : "No" }

func div(_ r: Int, _ x: Int) -> Bool {
  [1600 ... 2999, 1200 ... 2399][x].contains(r)
}

print(Yes(div(.stdin, .stdin - 1)))
