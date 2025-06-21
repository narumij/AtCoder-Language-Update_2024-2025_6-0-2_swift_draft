import AtCoder
import AcFoundation
import BigInt

extension static_modint: @retroactive IOIntegerConversionReadable {
  // 入力の制約が0からmod未満までの範囲の場合のみ利用可
  public static func convert(from: Int) -> Self { .init(rawValue: UInt(bitPattern: from)) }
}

extension BigInt: @retroactive IOIntegerConversionReadable {
  public static func convert(from: Int) -> Self { .init(from) }
}
