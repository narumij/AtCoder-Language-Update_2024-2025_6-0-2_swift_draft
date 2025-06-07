#!/bin/bash

# このインストールスクリプトはビルドシステムの結果を抽出してビルドスクリプトを生成します
# 将来このスクリプトに問題が生じた場合、
# 通常のインストール手順のスクリプトの以下と差し替えてください
# https://github.com/narumij/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/blob/main/dist/swift.normal.toml
# その場合、compileスクリプトは以下と差し替えてください
# https://github.com/narumij/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/blob/main/work/compile.normal.sh

LANG_VERSION=6.1.2

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

# このスクリプトでは、まず言語環境を構築し、その後ビルド環境を構築します。

# 新公式手順でのインストールにパッケージ不足がみられるため、
# 旧公式手順1を実行
# 確認してる警告は、libcurl4-openssl-devのみ。
# この手順は、様子を見て削ることが可能です。
sudo apt-get install -y \
             binutils \
             git \
             gnupg2 \
             libc6-dev \
             libcurl4-openssl-dev \
             libedit2 \
             libgcc-13-dev \
             libncurses-dev \
             libpython3-dev \
             libsqlite3-0 \
             libstdc++-13-dev \
             libxml2-dev \
             libz3-dev \
             pkg-config \
             tzdata \
             unzip \
             zlib1g-dev

# 公式 1. Download swiftly for Linux (Intel), or Linux (ARM).
curl -O https://download.swift.org/swiftly/linux/swiftly-1.0.0-$(uname -m).tar.gz

# 公式 2. You can verify the integrity of the archive using the PGP signature.
# This will download the signature, install the swift.org signatures into your keychain, and verify the signature.
curl https://www.swift.org/keys/all-keys.asc | gpg --import -
curl -O https://download.swift.org/swiftly/linux/swiftly-1.0.0-$(uname -m).tar.gz.sig
gpg --verify swiftly-1.0.0-$(uname -m).tar.gz.sig swiftly-1.0.0-$(uname -m).tar.gz

# 公式 3. Extract the archive with the following command:
tar -zxf swiftly-1.0.0-$(uname -m).tar.gz

# 公式 4. Run the following command in your terminal, to configure swiftly for your account, and automatically download the latest swift toolchain.
# バージョン選択を後続で行うため、インストールはスキップ
# 後続の処理が破損しないよう、assume-yesオプションを指定
./swiftly init --skip-install --assume-yes

# swifty初期化時に利用を継続する場合、以下を実行するよう指示があるため、実行
. "$HOME/.local/share/swiftly/env.sh"

# swiftyのログが何か言ってくるので、以下を実行
hash -r

# 公式 5. Now that swiftly and swift are installed, you can access the swift command from the latest Swift release:
# 公式 ?. Or, you can install (and use) another swift release:

swiftly install --use $LANG_VERSION
swift --version

# AtCoderからの要請で不要なファイルを削除するよう指示があるため、ダウンロードしたファイルを削除します
rm swiftly-1.0.0-$(uname -m).tar.gz
rm swiftly-1.0.0-$(uname -m).tar.gz.sig

# accelerate-linuxのビルドに必要なパッケージをインストールします
sudo apt-get install -y \
  "libopenblas-dev=0.3.26+ds-1" \
  "libopenblas0=0.3.26+ds-1" \
  "libopenblas-pthread-dev=0.3.26+ds-1" \
  "libopenblas0-pthread=0.3.26+ds-1" \
  "liblapacke-dev=3.12.0-3build1.1" \
  "liblapacke=3.12.0-3build1.1" \
  "libtmglib-dev=3.12.0-3build1.1" \
  "libtmglib3=3.12.0-3build1.1"

ls -al
which swift
swift --version

# これで言語環境の構築は完了しました

# 続いて、コンパイル環境の構築を行います
# コンパイル環境の構築では、AtCoderで使用するSwiftパッケージの初期化と依存パッケージの追加、そして事前ビルドを行います

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

# ジャッジがビルドを行う作業パッケージの初期化を行います。パッケージ名はMain、実行可能なプログラムとして初期化します
swift package init --name Main --type executable

# Package.swiftを更新し、AtCoderジャッジで使用する依存パッケージを作業パッケージに追加します
cat << 'EOF' > Package.swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "Main",
  
  // @MainActorとRegexをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
  
  dependencies: [
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.1.4"),
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリで、必須です
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.0.3"),
    // 吟味はしていません。将来誰かの助けになればと言う理由で搭載しています
    .package(
      url: "https://github.com/apple/swift-atomics",
      exact: "1.2.0"),
    // 吟味はしていません。将来誰かの助けになればと言う理由で搭載しています
    .package(
      url: "https://github.com/apple/swift-system",
      exact: "1.4.2"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.5.1"),
    // BigIntとの関連があり、浮動小数の精度不足を補えます
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      exact: "5.4.1"),
    // SIMDは他言語に対するSwiftのアドバンテージなので搭載しています
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    // SIMDやacceralateフレームワークに馴染んでいる人が他言語と異なる解法を試せるよう搭載しています
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "d6e80e8bc924e591e3ce68080e95a8046df1515a"),
    // 提案をそのまま受け入れて搭載しており、特に吟味していません
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      exact: "3.1.0"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      revision: "34c92e003a0ee0f42ced76c61c2bac6c6dac0d0d"),
//      exact: "0.1.10"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      exact: "0.1.15"),
    // atcoderでswiftが通用するためには欠かせません
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.24"),
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
EOF

# ビルドスクリプトを配置するフォルダを作成
mkdir Script

# 念の為に、クリーニングします
swift package clean

# 依存パッケージの解決とパッケージのビルドを事前に行います
swift \
  build \
  -c release \
  -v 1>&2 |& tee /dev/null

# 差分コンパイルが行われるよう、ソースコードを変更します
sed -i 's/Hello/Hallo/' Sources/main.swift

# 差分コンパイルを実施し、ビルドログを取得します
swift \
  build \
  -c release \
  -v > build.log

# ビルドログからビルドコマンドを抽出し、差分ビルドスクリプトを作成します
sed -n '/swiftc/{
    s/ -v / /;
    s/-parseable-output//;
    s/ -j[0-9][0-9]*/ -j1/g;
    s/ -num-threads [0-9][0-9]*/ -num-threads 1/g;
    p
}' build.log > Script/build.sh

# ビルドログを削除します
rm build.log

# ビルド結果を削除します
rm .build/release/Main

# 差分ビルドスクリプトを実行します
bash ./Script/build.sh

# Hello, world!を出力
.build/release/Main

# ジャッジによるビルド判定が正しく行われるよう、ビルド結果を削除します
rm .build/release/Main
