// swift-tools-version: 6.1
import PackageDescription

#if true
var swiftSettings: [SwiftSetting] = [
  .define("ONLINE_JUDGE")
]
#else
// 6.2以降でSE-0466を利用する
var swiftSettings: [SwiftSetting] = [
  .define("ONLINE_JUDGE"),
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
      exact: "1.2.0"),
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
    // 有理数です。ABC412あたりで話題だったので復活しました。
    // インストール手順がmainブランチ指定だったので、tagではなくrevision指定にしています。
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      revision: "7905f4e520bb601ed02a163d3c7410aa20f39c71"),
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
      // tag - 0.1.19
      revision: "71368ed8f6c0d47ff5f692bcf3152eea10dd7b9e"),
    // ABCに必須です。
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      // .unsafeFlags(["-std=c++17"])に対するビルド拒否を迂回するため、revision指定としている
      // branch - main
      revision: "90288b4efd3ed57308071ebaccfb8cb95d8f3a2b"),
    // ABCに必須です。
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.35"),
  ],
  
  targets: [
    .executableTarget(
      name: "Main",
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
      ],
      path: "Sources",
      swiftSettings: swiftSettings
    )
  ]
)
