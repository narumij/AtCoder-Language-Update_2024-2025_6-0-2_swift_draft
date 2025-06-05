@preconcurrency import Foundation

extension UnsafeMutableBufferPointer where Element == UInt8 {

  @inlinable
  @inline(__always)
  func _print() {
    forEach {
      putchar_unlocked(Int32($0))
    }
  }
  
  @inlinable
  @inline(__always)
  func print(terminater: Int32 = 0x0A) {
    _print()
    putchar_unlocked(terminater)
  }
}
