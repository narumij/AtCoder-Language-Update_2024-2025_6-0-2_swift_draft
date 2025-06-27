// swift-tools-version: 6.1
import PackageDescription

#if true
var swiftSettings: [SwiftSetting] = [
]
#else
// 6.2以降でSE-0466を利用する
var swiftSettings: [SwiftSetting] = [
  .defaultIsolation(.mainActor)
]
#endif

let package = Package(
  name: "Main",
  
  // @MainActorとRegexとType PackをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],

  dependencies: [
    // swift 5.8.1時点での既存ライブラリで、ABC必須です
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.1.4"),
    // swift 5.8.1時点での既存ライブラリです。ABC必須ではないですが、まれに有用でAC実績もあります。
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリですが、実数及び複素数であり、ABC必須ではありません。
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.0.3"),
    // 多倍長整数です。ABC必須です。
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.6.0"),
    // 2次元のSIMDはABCのマス目問題で有用で、まれに3次元のSIMDでABC提出の高速化が可能な場合があります。
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    // BLAS及びLAPACKなので、ABC必須ではありません。
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
    // ABCに必須です。
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      // tag - 0.1.17
      revision: "afc5997f42ee814fb5c7f4c383da25e5051c9ebd"),
    // ABCに必須です。
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      // .unsafeFlags(["-std=c++17"])に対するビルド拒否を迂回するため、revision指定としている
      // branch - main
      revision: "f77279740925341740f5dde683d21d81c09a95ec"),
    // ABCに必須です。
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.29"),
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
      path: "Sources",
      swiftSettings: swiftSettings
    )
  ]
)
