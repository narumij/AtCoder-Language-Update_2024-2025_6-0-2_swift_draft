import AtCoder
import AcFoundation

extension static_modint: @retroactive SingleReadable, @retroactive ArrayReadable {
  @inlinable @inline(__always)
  public static var stdin: Self {
    try! read()
  }
  @inlinable @inline(__always)
  public static func read() throws -> Self {
    .init(try Int.read())
  }
}
