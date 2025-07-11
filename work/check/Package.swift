// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "check",
    platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],

    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "check",
            targets: ["check"]),
    ],
    
    dependencies: [
      // swift 5.8.1時点での既存ライブラリで、必須です
      .package(
        url: "https://github.com/apple/swift-collections",
        from: "1.1.4"),
      // swift 5.8.1時点での既存ライブラリで、必須です
      .package(
        url: "https://github.com/apple/swift-algorithms",
        from: "1.2.1"),
      // swift 5.8.1時点での既存ライブラリで、必須です
      .package(
        url: "https://github.com/apple/swift-numerics",
        from: "1.0.3"),
      // atcoderでswiftが通用するためには欠かせません
      .package(
        url: "https://github.com/attaswift/BigInt",
        from: "5.5.1"),
      // SIMDは他言語に対するSwiftのアドバンテージなので搭載しています
      .package(
        url: "https://github.com/keyvariable/kvSIMD.swift",
        from: "1.1.0"),
      // SIMDやacceralateフレームワークに馴染んでいる人が他言語と異なる解法を試せるよう搭載しています
      .package(
        url: "https://github.com/brokenhandsio/accelerate-linux",
        branch: "main"),
      // atcoderでswiftが通用するためには欠かせません
      .package(
        url: "https://github.com/narumij/swift-ac-library",
        // -Ouncheckedを利用するためにrevision指定としている
        from: "0.1.12"),
      // atcoderでswiftが通用するためには欠かせません
      .package(
        url: "https://github.com/narumij/swift-ac-foundation",
        branch: "main"),
      // atcoderでswiftが通用するためには欠かせません
      .package(
        url: "https://github.com/narumij/swift-ac-collections",
        from: "0.1.26"),
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "check",
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
            ]),
        .testTarget(
            name: "checkTests",
            dependencies: ["check"]
        ),
    ]
)
