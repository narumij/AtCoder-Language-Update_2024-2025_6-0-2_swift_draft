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
      url: "https://github.com/apple/swift-numerics.git",
      revision: "e30276bff2ff5ed80566fbdca49f50aa160b0e83"),
//      branch: "main"),  // e30276b (after 1.0.2)
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
        .product(name: "AcCollections", package: "swift-ac-collections"),
      ],
      path: "Sources"
    )
  ]
)
