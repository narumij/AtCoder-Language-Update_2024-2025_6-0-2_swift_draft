// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "Main",
  
  // @MainActorとSwift MacrosをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections",
      revision: "78b544fbe20995ef5310337a86917c7ec40c863a"),
//      branch: "main"),  // 78b544f  (after 1.1.4)
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    .package(
      url: "https://github.com/apple/swift-numerics.git",
      revision: "2b458e8aeb9cf3f3a156f54ba427b9f101a4511a"),
//      branch: "main"),  // e30276b (after 1.0.3)
//      exact: "1.0.3"),
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
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      revision: "f0e90fc0700a6b2dda771439a2d14ec8b911e28f"),
//      exact: "0.1.5"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      exact: "0.1.2"),
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.13"),
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
