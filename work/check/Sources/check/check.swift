import AcFoundation
import Collections
import Algorithms

import Foundation


func hoge() {

  func solve() {
    let _ = Int(readLine()!)!
    let A = readLine()!.components(separatedBy: " ").compactMap(Int.init)
    var first = A.first!
    let last = A.last!
    let sorted = A.filter { (first...last).contains($0) }.sorted()
    var ans = 2
    while true {
      let i = sorted.bisectLeft(first * 2)
      if sorted[i] == sorted.last {
        break
      } else if sorted[i] == first {
        ans = -1
      } else {
        ans += 1
        first = sorted[i]
      }
    }
    print(ans)
  }
  
  let T = Int(readLine()!)!
  for _ in 0 ..< T {
    solve()
  }
}

extension Collection where Index == Int, Element: Comparable {

  /**
   指定された要素 `x` を挿入するための最も右側のインデックスを返します（リストがソートされていることを前提）。

   このメソッドは次の条件を満たすインデックスを返します:
   - `self[..<i]` のすべての要素 `e` が `e <= x` であり、
   - `self[i...]` のすべての要素 `e` が `e > x` です。

   もし `x` がすでにコレクション内に存在している場合でも、`x` が最も右側に挿入されるインデックスが返されます。

   - Parameter x: 挿入するために検索する要素。
   - Returns: 挿入するべき最も右側のインデックス。
   */
  @inlinable
  public func bisectRight(_ x: Element) -> Index {
    var (lo, hi): (Index, Index) = (startIndex, endIndex)
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if x < self[mid] {
        hi = mid
      } else {
        lo = mid + 1
      }
    }
    return lo
  }

  /**
   指定された要素 `x` を挿入するための最も左側のインデックスを返します（リストがソートされていることを前提）。

   このメソッドは次の条件を満たすインデックスを返します:
   - `self[..<i]` のすべての要素 `e` が `e < x` であり、
   - `self[i...]` のすべての要素 `e` が `e >= x` です。

   もし `x` がすでにコレクション内に存在している場合でも、`x` が最も左側に挿入されるインデックスが返されます。

   - Parameter x: 挿入するために検索する要素。
   - Returns: 挿入するべき最も左側のインデックス。
   */
  @inlinable
  public func bisectLeft(_ x: Element) -> Index {
    var (lo, hi): (Index, Index) = (startIndex, endIndex)
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if self[mid] < x {
        lo = mid + 1
      } else {
        hi = mid
      }
    }
    return lo
  }
}

extension Collection where Index == Int {

  /**
   指定された要素 `x` を挿入するための最も右側のインデックスを返します（リストがソートされていることを前提）。

   キー関数 `key` を用いて各要素を比較します。

   このメソッドは次の条件を満たすインデックスを返します:
   - `self[..<i]` のすべての要素 `e` が `key(e) <= x` であり、
   - `self[i...]` のすべての要素 `e` が `key(e) > x` です。

   もし `x` がすでにコレクション内に存在している場合でも、`x` が最も右側に挿入されるインデックスが返されます。

   - Parameters:
     - x: 挿入するために検索する値。
     - key: 各要素から比較に使用する値を取得するためのキー関数。
   - Returns: 挿入するべき最も右側のインデックス。
   */
  @inlinable
  public func bisectRight<T: Comparable>(_ x: T, key: ((Element) -> T)) -> Index {
    var (lo, hi): (Index, Index) = (startIndex, endIndex)
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if x < key(self[mid]) {
        hi = mid
      } else {
        lo = mid + 1
      }
    }
    return lo
  }

  /**
   指定された要素 `x` を挿入するための最も左側のインデックスを返します（リストがソートされていることを前提）。

   キー関数 `key` を用いて各要素を比較します。

   このメソッドは次の条件を満たすインデックスを返します:
   - `self[..<i]` のすべての要素 `e` が `key(e) < x` であり、
   - `self[i...]` のすべての要素 `e` が `key(e) >= x` です。

   もし `x` がすでにコレクション内に存在している場合でも、`x` が最も左側に挿入されるインデックスが返されます。

   - Parameters:
     - x: 挿入するために検索する値。
     - key: 各要素から比較に使用する値を取得するためのキー関数。
   - Returns: 挿入するべき最も左側のインデックス。
   */
  @inlinable
  public func bisectLeft<T: Comparable>(_ x: T, key: ((Element) -> T)) -> Index {
    var (lo, hi): (Index, Index) = (startIndex, endIndex)
    while lo < hi {
      let mid = lo + (hi - lo) / 2
      if key(self[mid]) < x {
        lo = mid + 1
      } else {
        hi = mid
      }
    }
    return lo
  }
}

extension RangeReplaceableCollection where Index == Int, Element: Comparable {

  /**
   ソートされていることを前提として、指定された要素 `x` をコレクションに挿入します。

   このメソッドは、`x` を適切な位置に挿入して、コレクションのソート順を維持します。
   もし `x` がすでにコレクション内に存在している場合は、`x` を既存の最も右側の `x` の直後に挿入します。

   - Parameter x: 挿入する要素。
   */
  @inlinable
  public mutating func insortRight(_ x: Element) {
    let lo = bisectRight(x)
    insert(x, at: lo)
  }

  /**
   ソートされていることを前提として、指定された要素 `x` をコレクションに挿入します。

   このメソッドは、`x` を適切な位置に挿入して、コレクションのソート順を維持します。
   もし `x` がすでにコレクション内に存在している場合は、`x` を既存の最も左側の `x` の直前に挿入します。

   - Parameter x: 挿入する要素。
   */
  @inlinable
  public mutating func insortLeft(_ x: Element) {
    let lo = bisectLeft(x)
    insert(x, at: lo)
  }
}

extension RangeReplaceableCollection where Index == Int {

  /**
   ソートされていることを前提として、指定された要素 `x` をコレクションに挿入します。

   このメソッドは、カスタムキー関数 `key` を用いて要素を比較し、`x` を適切な位置に挿入してコレクションのソート順を維持します。
   もし `x` がすでにコレクション内に存在している場合は、`x` を既存の最も右側の `x` の直後に挿入します。

   - Parameters:
     - x: 挿入する要素。
     - key: 各要素から比較に使用する値を取得するためのキー関数。
   */
  @inlinable
  public mutating func insortRight<T: Comparable>(_ x: Element, key: ((Element) -> T)) {
    let lo = bisectRight(key(x), key: key)
    insert(x, at: lo)
  }

  /**
   ソートされていることを前提として、指定された要素 `x` をコレクションに挿入します。

   このメソッドは、カスタムキー関数 `key` を用いて要素を比較し、`x` を適切な位置に挿入してコレクションのソート順を維持します。
   もし `x` がすでにコレクション内に存在している場合は、`x` を既存の最も左側の `x` の直前に挿入します。

   - Parameters:
     - x: 挿入する要素。
     - key: 各要素から比較に使用する値を取得するためのキー関数。
   */
  @inlinable
  public mutating func insortLeft<T: Comparable>(_ x: Element, key: ((Element) -> T)) {
    let lo = bisectLeft(key(x), key: key)
    insert(x, at: lo)
  }
}
