import AcCollections
import AcFoundation
import AcMemoize
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

let alphabets: [String] = [
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
  "T", "U", "V", "W", "X", "Y", "Z",
]

let (N, Q) = (Int.stdin, Int.stdin)

typealias modint = modint998244353
var M: modint = .stdin

nonisolated(unsafe) var q: Int = 0

struct AB: Hashable {
  let A: Int
  let B: Int
}

nonisolated(unsafe) var memo: [AB: Bool] = [:]

func q(_ A: Int, _ B: Int,_ memo: [AB:Bool]) -> Bool? { memo[AB(A: A, B: B)] }
func cache(_ A: Int,_ B: Int,_ result: Bool,_ memo: inout [AB:Bool]) {
  if result {
    memo[AB(A: A, B: B)] = true
    memo[AB(A: B, B: A)] = false
  }
  else {
    memo[AB(A: A, B: B)] = false
    memo[AB(A: B, B: A)] = true
  }
}
func query(_ A: Int, _ B: Int,_ memo: (Int,Int) -> Bool?,_ cache: (Int,Int,Bool) -> Void) throws -> Bool {
  if let result = memo(A, B) {
    return result
  }
  if q >= Q {
    throw Error.limit
  }
  print("? \(alphabets[A]) \(alphabets[B])")
  fflush(stdout)
  q += 1
  let result = readLine() == "<"
  cache(A, B, result)
  return result
}
func q(_ A: Int, _ B: Int) -> Bool? { q(A,B,memo) }
func cache(_ A: Int,_ B: Int,_ result: Bool) {
  cache(A, B, result, &memo)
}
func query(_ A: Int, _ B: Int) throws -> Bool {
  try query(A, B, q, cache)
}

func mapping<T>(_ a: T) -> [Int: Int] where T: Collection, T.Element == Int {
  .init(uniqueKeysWithValues: a.enumerated().map { ($0.element, $0.offset) })
}

func check<T>(_ a: T,_ memo: [AB:Bool]) -> Bool where T: Collection, T.Element == Int {
  let mapped = mapping(a)
  for (key, value) in memo where value == true {
    if mapped[key.A]! < mapped[key.B]! {
      continue
    }
    return false
  }
  return true
}

func check<T>(_ a: T) -> Bool where T: Collection, T.Element == Int {
  check(a, memo)
}

nonisolated(unsafe) var labels = [Int](0..<N)

//let q5 = [(0,2),(1,3),(0,1),(4,1),(2,3),(3,4),(0,4),(1,2),(2,0),(3,1),(4,0)]

func counts(_ memo: [AB:Bool]) -> Int {
  labels.permutations().filter{ check($0,memo) }.count
}

func counts(_ A: Int,_ B: Int,_ result: Bool,_ memo: [AB:Bool]) -> (c: Int, f: Int) {
  var memo = memo
  cache(A, B, result, &memo)
  let maps = labels.permutations().filter(check).map(mapping)
  var f = 0
  for i in 0 ..< N {
    for j in i ..< N where i != j && memo.allSatisfy({ $0.key != .init(A: i, B: j) }) {
      if maps.allSatisfy({ $0[i]! < $0[j]! }) {
        print("Found!",i,j, to: &stderr)
        cache(i, j, true, &memo)
        f += 1
      }
      if maps.allSatisfy({ $0[i]! > $0[j]! }) {
        print("Found!",i,j, to: &stderr)
        cache(i, j, false, &memo)
        f += 1
      }
    }
  }
  return (counts(memo), f)
}

func minimums() -> (Int,Int) {
  var dict = [Int:[(Int,Int)]]()
  var dict2 = [Int:[(Int,Int)]]()
  for i in 0 ..< N {
    for j in i ..< N where i != j {
      let a = counts(i,j,true,memo)
      let b = counts(i,j,false,memo)
      if let n = [a.f != 0 ? a.f : nil, b.f != 0 ? b.f : nil].compactMap({$0}).max() {
      dict[n, default: []].append((i,j))
    }
      dict2[min(a.c,b.c), default: []].append((i,j))
    }
  }
//  return dict.max{ $0.key < $1.key }.flatMap {
//    $0.value.randomElement()
//  } ??
  return dict2.min{ $0.key < $1.key }.flatMap {
    $0.value.randomElement()
  }!
}

func q5() -> (Int, Int) {
  switch q {
  case 0:
    return (0, 2)
  case 1:
    return (1, 3)
  case 2:
    return (0, 4)
//  case 3:
//    return (3, 4)
  default:
//    let a = (0..<N).randomElement()!
//    let b = (0..<N).filter{ $0 != a }.randomElement()!
//    return (a,b)
    return minimums()
  }
}

if N == 5 {
  do {
    while q < Q {
      print(q,")", to: &stderr)
      //    let (a,b) = (Int.stdin, Int.stdin)
      let (a, b) = q5()
      try query(a, b)
      var c = 0
      
      // ABCDE
      let maps = labels.permutations().filter(check).map(mapping)
      for i in 0 ..< N {
        for j in i ..< N where i != j && memo.allSatisfy({ $0.key != .init(A: i, B: j) }) {
          if maps.allSatisfy({ $0[i]! < $0[j]! }) {
            print("Found!",i,j, to: &stderr)
            cache(i, j, true)
          }
          if maps.allSatisfy({ $0[i]! > $0[j]! }) {
            print("Found!",i,j, to: &stderr)
            cache(i, j, false)
          }
        }
      }

      var last = labels
      for aa in labels.permutations() where check(aa) {
        print("! \(aa.map{ alphabets[$0] }.joined())", to: &stderr)
        c += 1
        last = aa.map { $0 }
      }
      print("count =", c, to: &stderr)
      if c == 1 {
        labels = last
        break
      }
    }
  } catch {
  }
} else {
  do {
    try labels.sort(by: query)
  } catch {
  }
}
print("! \(labels.map{ alphabets[$0] }.joined())")
fflush(stdout)

enum Error: Swift.Error {
  case limit
}
