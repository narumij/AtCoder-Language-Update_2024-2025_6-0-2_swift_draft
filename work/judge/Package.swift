// swift-tools-version: 6.0
import PackageDescription

// TODO: 最終版では、fromをexactに変更すること
let package = Package(
  name: "Main",
  platforms: [
      .macOS(.v10_15),  // macOS 10.15 以上
      // Linux はプラットフォームリストには含めませんが、サポートされます
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      exact: "1.1.4"),
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-numerics",
//      branch: "main"),  // e30276b
      revision: "e30276bff2ff5ed80566fbdca49f50aa160b0e83"),
    .package(
      url: "https://github.com/apple/swift-atomics",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-system",
      exact: "1.4.0"),
    .package(
      url: "https://github.com/attaswift/BigInt.git",
      exact: "5.5.0"),
    .package(
      url: "https://github.com/dankogai/swift-bignum.git",
      exact: "5.4.1"),
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      from: "0.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      from: "0.0.5"),
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      from: "0.0.2"),
  ],
  targets: [
    .executableTarget(
      name: "Main",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "Atomics", package: "swift-atomics"),
        .product(name: "SystemPackage", package: "swift-system"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "BigNum", package: "swift-bignum"),
        .product(name: "SwiftGraph", package: "SwiftGraph"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
        .product(name: "AcCollections", package: "swift-ac-collections"),
      ],
      path: "Sources"
    )
  ]
)
