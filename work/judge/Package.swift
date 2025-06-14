// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "Main",
  
  // @MainActorとRegexをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
  
  dependencies: [
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.1.4"),
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.0.3"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.6.0"),
    // SIMDは他言語に対するSwiftのアドバンテージなので搭載しています
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    // SIMDやacceralateフレームワークに馴染んでいる人が他言語と異なる解法を試せるよう搭載しています
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      revision: "7c6b28380e95cff5545e3e59b12eaeeab3cca757"),
//      exact: "0.1.15"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      exact: "0.1.15"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.27"),
  ],
  
  targets: [
    .executableTarget(
      name: "Main",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "kvSIMD", package: "kvSIMD.swift"),
        .product(name: "AccelerateLinux", package: "accelerate-linux"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
        .product(name: "AcCollections", package: "swift-ac-collections"),
      ],
      path: "Sources"
    )
  ]
)
