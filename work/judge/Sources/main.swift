@preconcurrency import Foundation
import Collections
import Algorithms
import Numerics
import IntegerUtilities
import AtCoder
import AcFoundation
import IOReader
import IOUtil
import Bisect
import AcCollections
import RedBlackTreeModule
import PermutationModule
import Numerics
import BigInt
import BigNum
import SwiftGraph
import AcMemoize

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

@preconcurrency import Foundation
import AcFoundation

let alphabets: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

let (N,Q) = (Int.stdin, Int.stdin)

nonisolated(unsafe) var q: Int = 0

struct AB: Hashable {
  let A: Int
  let B: Int
}

nonisolated(unsafe) var memo: [AB:Bool] = [:]

func query(_ A: Int, _ B: Int) throws -> Bool {
  if let result = memo[AB(A: A, B: B)] {
    return result
  }
  
  if q >= Q {
    throw Error.limit
  }
  print("? \(alphabets[A]) \(alphabets[B])")
  fflush(stdout)
  q += 1
  let result = readLine() == "<"
  
  memo[AB(A: A, B: B)] = result
  memo[AB(A: B, B: A)] = !result

  return result
}

nonisolated(unsafe) var labels = [Int](0..<N)

if N == 5 {
  
}
else {
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



import AtCoder
import AcFoundation
import AcCollections

let (H, W, _) = (Int.stdin, Int.stdin, Int.stdin)

let _g1 = RedBlackTreeSet<Int>(0 ..< W)
let _g2 = RedBlackTreeSet<Int>(0 ..< H)

nonisolated(unsafe) var g1: [RedBlackTreeSet<Int>] = [_g1] * H
nonisolated(unsafe) var g2: [RedBlackTreeSet<Int>] = [_g2] * W

func erase(_ i: Int, _ j: Int) {
  _ = g1[i].remove(j)
  _ = g2[j].remove(i)
}

for _ in 0..<Q {
  let (R, C) = (Int.stdin - 1, Int.stdin - 1)
  
  if g1[R].contains(C) {
    erase(R, C)
    continue
  }
  
  if let r = g2[C].lowerBound(R).previous?.pointee {
    erase(r, C)
  }
  
  if let r = g2[C].lowerBound(R).pointee {
    erase(r, C)
  }
  
  if let c = g1[R].lowerBound(C).previous?.pointee {
    erase(R, c)
  }
  
  if let c = g1[R].lowerBound(C).pointee {
    erase(R, c)
  }
}

var ans = 0
for i in 0..<H {
  ans += g1[i].count
}

print(ans)

extension Array {
  @inlinable
  static func * (lhs: Self, rhs: Int) -> Self {
    repeatElement(lhs, count: rhs).flatMap { $0 }
  }
  @inlinable
  static func * (lhs: Self, rhs: (A: Int, B: Int)) -> [Self] {
    [lhs * rhs.B] * rhs.A
  }
  @inlinable
  static func * (lhs: Self, rhs: (A: Int, B: Int, C: Int)) -> [[Self]] {
    [[lhs * rhs.C] * rhs.B] * rhs.A
  }
  @inlinable
  static func * (lhs: Self, rhs: (A: Int, B: Int, C: Int, D: Int)) -> [[[Self]]] {
    [[[lhs * rhs.D] * rhs.C] * rhs.B] * rhs.A
  }
}
