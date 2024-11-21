// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "Main",
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      exact: "1.1.4"),
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      branch: "main"),
    .package(
      url: "https://github.com/apple/swift-system",
      exact: "1.4.0"),
    .package(
      url: "https://github.com/attaswift/BigInt.git",
      from: "5.4.1"),
    .package(
      url: "https://github.com/dankogai/swift-bignum.git",
      from: "5.4.1"),
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      branch: "main"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      branch: "main"),
  ],
  targets: [
    .executableTarget(
      name: "Main",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "SystemPackage", package: "swift-system"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "BigNum", package: "swift-bignum"),
        .product(name: "SwiftGraph", package: "SwiftGraph"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
      ],
      path: "Sources"
    )
  ]
)
