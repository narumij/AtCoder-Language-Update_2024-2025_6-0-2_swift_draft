// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "JudgeLibraries",
  platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
  products: [.library(name: "JudgeLibraries", type: .static, targets: ["JudgeLibraries"])],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.1.0"),
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.7.0"),
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      revision: "a562275f0a64bc95f6e3f6c45ee652eefa820749"),
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      revision: "528c893e8d9b74acbfd455781e9a4bb6c5a5a262"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      revision: "9affe451d311e3c82c7eb3aefd06b22565cf1508"),
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.44"),
    .package(
      url: "https://github.com/narumij/swift-ac-memoize",
      revision: "b99737071fd3cc156d66d972a6c72b89fc7150af"),
  ],
  targets: [
    .target(
      name: "JudgeLibraries",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "BigNum", package: "swift-bignum"),
        .product(name: "kvSIMD", package: "kvSIMD.swift"),
        .product(name: "AccelerateLinux", package: "accelerate-linux"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
        .product(name: "AcCollections", package: "swift-ac-collections"),
        .product(name: "AcMemoize", package: "swift-ac-memoize"),
      ],
      path: "Sources",
      swiftSettings: [
        .define("ONLINE_JUDGE"),
        .defaultIsolation(nil)
      ]
    )
  ]
)
