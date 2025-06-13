#if true
@preconcurrency import Foundation
import AcCollections
import AcFoundation
import Algorithms
import AtCoder
import BigInt
import BigNum
import Bisect
import Collections
import IOReader
import IOUtil
import Numerics
import PermutationModule
import RedBlackTreeModule
import simd
import SwiftGraph

#if canImport(Glibc)
import AccelerateLinux
#else
import Accelerate
#endif

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

//print(Yes(div(.stdin, .stdin - 1)))
//
//let N,Q: Int
//(N,Q) = readLine()!

// 'keyAndValue' is created using a regex literal
let keyAndValue = /(.+?): (.+)/
// 'simpleDigits' is created from a pattern in a string
let simpleDigits = try Regex("[0-9]+")

let setting = "color: 161 103 230"
if setting.contains(simpleDigits) {
    print("'\(setting)' contains some digits.")
}

print({ $0 % 2 == 0 ? $0 : nil }(1))

typealias TreeDict = RedBlackTreeDictionary

let treeDict: TreeDict<Int,Double> = [(0,1),(2,3),(4,5)]

print(treeDict.mapValues(sqrt))

let dict: Dictionary<Int,Double> = .init(uniqueKeysWithValues: treeDict.mapValues(sqrt).map{ $0 })

print(dict.map { $0 })

//let aa: Array<Character> = Array(readLine()!)

var bigNum = (BigRat(1) / BigRat(2)).rounded(.down)

print(bigNum)

#else

import Foundation
import AtCoder
import AcFoundation

let T = Int.stdin
for i in 0 ..< T {
    fastPrint(floor_sum(.stdin, .stdin, .stdin, .stdin))
}

#endif
