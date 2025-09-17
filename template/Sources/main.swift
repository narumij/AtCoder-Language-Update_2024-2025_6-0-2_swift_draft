#if false
// 更新成功したら通るはずのコード
import AcCollections
import AcFoundation
import AcMemoize
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
#endif

#if false
try main()

@MainActor
public func main() throws {

//  let A: [Int] = try [Int].readLine()
    let A: [Int] = [1, 2, 3, 4, 5, 6]
  //  let A: [Int] = [1,1,1,1,1,1]
  var deme: [[[Int]: BigRat]] = [[:]] * 6
  for n in 1..<6 {
    let deno = 6 ** n
    for idxs in (0..<6).product(ofCount: n) {
      deme[n][idxs.sorted(), default: 0] += BigRat(1, deno)
    }
  }

  @Memoize
  func f(_ rest_turn: Int, _ keep_idxs: [Int]) -> BigRat {
    if keep_idxs.count == 5 {
      var count = [Int: Int]()
      for idx in keep_idxs {
        count[A[idx], default: 0] += 1
      }
      return .init(count.map { $0 * $1 }.max()!)
    }
    let rest_dice = 5 - keep_idxs.count
    var ans: BigRat = 0
    for deme_idxs in (0..<6).product(ofCount: rest_dice) {
      let prob: BigRat = .init(1, 6 ** rest_dice)
      var M: BigRat = 0
      let keeps: [Int] = rest_turn != 1 ? (0..<1 << rest_dice) + [] : [(1 << rest_dice) - 1]
      for keep in keeps {
        var new_idxs: [Int] = keep_idxs
        for i in 0..<deme_idxs.count where keep >> i & 1 == 1 {
          new_idxs.append(deme_idxs[i])
        }
        M = max(M, f(rest_turn - 1, new_idxs.sorted()))
      }
      ans += M * prob
    }
    return ans
  }

  print(f(3, []).asDouble)
}

extension Sequence {

  @inlinable
  @inline(never)
  func product(ofCount n: Int) -> [[Element]] {
    if n == 0 { return [[]] }
    let smaller = product(ofCount: n - 1)
    var result: [[Element]] = []
    for prefix in smaller {
      for x in self {
        result.append(prefix + [x])
      }
    }
    return result
  }
}
#endif

#if false
import Foundation

@usableFromInline
nonisolated(unsafe) var buffer: [Int32] = Array(repeating: 0, count: 1024)

let N: Int = __readLine()
for _ in 0..<N {
  let (a,b) = __readLine()
  fastPrint(a + b)
}

func __readLine_stdin(_ p: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>) -> Int {
  var capacity = 0
  var result = 0
  repeat {
    result = getline(p, &capacity, stdin)
  } while result < 0 && errno == EINTR
  return result
}

public func __readLine<T>(_ f: (UnsafePointer<CChar>, Int) throws -> T) throws -> T {
  var utf8Start: UnsafeMutablePointer<CChar>?
  let utf8Count = __readLine_stdin(&utf8Start)
  defer {
    free(utf8Start)
  }
  return try f(utf8Start!, utf8Count)
}

@inlinable
func __read<Integer>(_ start: UnsafePointer<CChar>,_ count: Int,_ pos: inout Int) -> Integer where Integer: FixedWidthInteger & SignedInteger {
  while pos < count, start[pos] == 0x20 {
    pos += 1
  }
  var num: Integer = 0
  var negative: Bool = false
  var c: Integer = Integer(start[pos])
  pos += 1
  if c == 0x2D {
    negative = true
  } else {
    num = c - 0x30
  }
  while true {
    c = Integer(start[pos])
    pos += 1
    if (1 << c) & (1 << 0x0A | 1 << 0x20) != 0 {
      break
    }
    num = num * 10 + (negative ? -(c &- 0x30) : (c &- 0x30))
  }
  return num
}

public func __readLine() -> Int {
  try! __readLine { start, count in
    var pos = 0
    return __read(start, count, &pos)
  }
}

public func __readLine() -> (Int, Int) {
  try! __readLine { start, count in
    var pos = 0
    return (__read(start, count, &pos), __read(start, count, &pos))
  }
}

@inlinable
public func fastPrint<I>(_ x: I, terminater: Int32? = 0x0A)
where I: FixedWidthInteger & SignedInteger {
  ___print_int(x)
  if let terminater {
    putchar_unlocked(terminater)
  }
}

@inlinable
func ___print_int<I>(_ x: I) where I: FixedWidthInteger & SignedInteger {
  if (x < 0) {
    ___print_negative(x)
  }
  else {
    ___print_positive(x)
  }
}

@inlinable
func ___print_positive<I>(_ x: I) where I: FixedWidthInteger {
  var x = x
  buffer.withUnsafeMutableBufferPointer { buffer in
  var i = 0;
  repeat {
    let r: I
    (x, r) = x.quotientAndRemainder(dividingBy: 10)
    buffer[i] = Int32(0x30 | r);
    i += 1;
  } while (x > 0);
  while (i > 0) {
    i -= 1;
    putchar_unlocked(buffer[i]);
  }
  }
}

@inlinable
func ___print_negative<I>(_ x: I) where I: FixedWidthInteger & SignedInteger {
  var x = x
  buffer.withUnsafeMutableBufferPointer { buffer in
    putchar_unlocked(0x2D);
    var i = 0;
    repeat {
      let r: I
      (x, r) = x.quotientAndRemainder(dividingBy: 10)
      buffer[i] = Int32(0x30 | -r);
      i += 1;
    } while (x < 0);
    while (i > 0) {
      i -= 1;
      putchar_unlocked(buffer[i]);
    }
  }
}
#endif

import AcFoundation
import Collections
import IOUtil

let n: Int = .stdin
var v: [Pack<Int,Int>]
v = (0 ..< n)
  .map{ _ in (Int.stdin, Int.stdin) }
  .map { t,d in .init(t, t + d) }
  .sorted()

var pq = Heap<Int>()
var it = 0
var ans = 0
var i = 0
while true {
    if pq.isEmpty {
        if it == n { break }
      i = v[it].rawValue.0
    }
    while it < n, v[it].rawValue.0 == i {
        pq.insert(v[it].rawValue.1)
        it += 1
    }
    while !pq.isEmpty, pq.min! < i { _ = pq.popMin() }
    if !pq.isEmpty {
        _ = pq.popMin()
        ans += 1
    }
    i += 1
}

fastPrint(ans)
