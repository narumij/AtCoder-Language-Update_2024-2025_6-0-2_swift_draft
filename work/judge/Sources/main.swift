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
