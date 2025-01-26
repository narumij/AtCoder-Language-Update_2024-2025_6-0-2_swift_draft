// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "Main",
  
  // @MainActorとSwift MacrosをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections",
      revision: "52a1f698d5faa632df0e1219b1bbffa07cf65260"),
//      branch: "main"),  // 52a1f69  (after 1.1.4)
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      revision: "e30276bff2ff5ed80566fbdca49f50aa160b0e83"),
//      branch: "main"),  // e30276b (after 1.0.2)
    .package(
      url: "https://github.com/apple/swift-atomics",
      exact: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-system",
      exact: "1.4.0"),
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.5.1"),
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      exact: "5.4.1"),
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      revision: "c9aa78bd18d5a3f2608c0583187344334d7a1652"),
//      exact: "0.1.4"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      exact: "0.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.10"),
    .package(
      url: "https://github.com/narumij/swift-ac-memoize",
      exact: "0.1.2"),
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
        .product(name: "AcMemoize", package: "swift-ac-memoize"),
      ],
      path: "Sources"
    )
  ]
)
