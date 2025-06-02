// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "Main",
  
  // @MainActorとRegexをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
  
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.1.4"),
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.0.3"),
    .package(
      url: "https://github.com/apple/swift-atomics",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-system",
      exact: "1.4.2"),
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.5.1"),
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      exact: "5.4.1"),
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "d6e80e8bc924e591e3ce68080e95a8046df1515a"),
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      revision: "29f52ea9b1c791f5280b82275d38e6d49ae5a3a3"),
//      exact: "0.1.9"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      exact: "0.1.15"),
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.19"),
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
