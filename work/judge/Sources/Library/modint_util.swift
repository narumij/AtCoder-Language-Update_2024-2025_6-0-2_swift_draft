import AtCoder
import AcFoundation
import BigInt

extension static_modint: @retroactive IOIntegerConversionReadable {
  public static func convert(from: Int) -> Self { .init(from) }
}

extension BigInt: @retroactive IOIntegerConversionReadable {
  public static func convert(from: Int) -> Self { .init(from) }
}
