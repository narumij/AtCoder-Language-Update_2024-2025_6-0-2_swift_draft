//
//  internal.swift
//  Main
//
//  Created by narumij on 2025/05/03.
//

@usableFromInline
enum _Internal { }

extension _Internal {

  /// @param n `1 <= n`
  /// @return same with std::bit::countr_zero
  @inlinable
  @inline(__always)
  static func bit_ceil<I: FixedWidthInteger>(_ n: I) -> Int {
    return n <= 1 ? 1 : 1 << (I.bitWidth - (n - 1).leadingZeroBitCount)
  }

  /// @param n `1 <= n`
  /// @return same with std::bit::countr_zero
  @inlinable
  @inline(__always)
  static func countr_zero<I: FixedWidthInteger>(_ n: I) -> Int {
    assert(1 <= n)
    return n.trailingZeroBitCount
  }
}
