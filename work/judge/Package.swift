// swift-tools-version: 6.1
import PackageDescription

#if true
  var swiftSettings: [SwiftSetting] = [
    .define("ONLINE_JUDGE")
  ]
#else
  var swiftSettings: [SwiftSetting] = [
    .define("ONLINE_JUDGE"),
    // 6.2以降でSE-0466を利用する
    .defaultIsolation(.mainActor),
  ]
#endif

let package = Package(
  name: "Main",

  // @MainActorとRegexとType PackをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],

  dependencies: [
    // swift 5.8.1時点での既存ライブラリです
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.2.0"),
    // swift 5.8.1時点での既存ライブラリです。
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリで、実数及び複素数です。
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.0.3"),
    // 多倍長整数です。
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.6.0"),
    // 有理数です。
    // インストール手順がmainブランチ指定だったので、tagではなくrevision指定にしています。
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      revision: "7905f4e520bb601ed02a163d3c7410aa20f39c71"),
    // SIMDです。
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    // BLAS及びLAPACKです。
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
    // Atcoder LibraryのSwift版です。
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      // tag - 0.1.22
      revision: "488e2f1cb8caf0577df59a3674b49fe9b3f827df"),
    // 高速な入力、二分探索、その他便利関数です。
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      // .unsafeFlags(["-std=c++17"])に対するビルド拒否を迂回するため、revision指定としている
      // branch - main
      revision: "6c804b5b19c6a04743f2c51f0cdf2eacfbe52921"),
    // 平衡二分探索木と順列全列挙です。
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.38"),
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
