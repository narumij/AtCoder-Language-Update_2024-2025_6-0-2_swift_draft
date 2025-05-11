import AtCoder
import AcFoundation

public protocol IntegerReadable: SingleReadable, ArrayReadable, LineReadable {
  init(_ :Int)
}

extension IntegerReadable {
  @inlinable @inline(__always)
  public static func readWithSeparator() throws -> (value: Self, separator: UInt8) {
    let (a,b) = try Int.readWithSeparator()
    return (.init(a),b)
  }
}

extension static_modint: IntegerReadable { }

