import Foundation

extension UInt8: ExpressibleByStringLiteral {
  @inlinable
  public init(stringLiteral value: String) {
    self = value.utf8.first!
  }
}

