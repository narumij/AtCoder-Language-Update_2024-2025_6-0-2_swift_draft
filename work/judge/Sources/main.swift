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

let n: Int = .stdin
var v: [(first: Int, second: Int)]
v = (0 ..< n)
  .map{ _ in (Int.stdin, Int.stdin) }
    .map { t,d in (t, t + d)}
    .sorted { (l: (Int,Int), r: (Int,Int)) in
        l.0 < r.0 || (l.0 == r.0 && l.1 < r.1)
    }

var pq = Heap<Int>()
var it = 0
var ans = 0
var i = 0
while true {
    if pq.isEmpty {
        if it == n { break }
        i = v[it].first
    }
    while it < n, v[it].first == i {
        pq.insert(v[it].second)
        it += 1
    }
    while !pq.isEmpty, pq.min! < i { _ = pq.popMin() }
    if !pq.isEmpty {
        _ = pq.popMin()
        ans += 1
    }
    i += 1
}
print(ans)


import AtCoder
import AcFoundation

var dsu = DSU(.N)
for _ in 0 ..< .Q {
    switch .t as Int {
    case 0:
      _ = dsu.merge(.u, .v)
    case 1:
      fastPrint(dsu.same(.u, .v) ? 1 : 0)
    default:
      fatalError()
    }
}

extension Int {
  static var N: Self { .stdin }
  static var Q: Self { .stdin }
  static var t: Self { .stdin }
  static var u: Self { .stdin }
  static var v: Self { .stdin }
}
