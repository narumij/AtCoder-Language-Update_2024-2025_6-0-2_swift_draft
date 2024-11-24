#!/bin/bash

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.2
SDK_VERSION=0.0.1

SWIFT_BRANCH=swift-${LANG_VERSION}-release
SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_WEBROOT=https://download.swift.org
SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
OS_ARCH_SUFFIX="" # arm64等の場合に指定する
FILE_NAME="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"
SWIFT_TAR_BALL_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$FILE_NAME.tar.gz"
SWIFT_TAR_BALL_FILE="$FILE_NAME.tar.gz"

STATIC_LINUX_SDK_URL=https://download.swift.org/swift-${LANG_VERSION}-release/static-sdk/swift-${LANG_VERSION}-RELEASE/swift-${LANG_VERSION}-RELEASE_static-linux-${SDK_VERSION}.artifactbundle.tar.gz
STATIC_LINUX_SDK_CHECKSUM=aa5515476a403797223fc2aad4ca0c3bf83995d5427fb297cab1d93c68cee075
SWIFT="./${$FILE_NAME}/usr/bin/swift"

export DEBIAN_FRONTEND=noninteractive

# このスクリプトでは、まず言語環境を構築し、その後ビルド環境を構築します。

# ここから、言語環境の構築を開始します。
# 言語環境の構築では、Swift toolchainの展開と、Static Linux SDKのインストールを行います。
# Swift toolchainの展開手順は、Swift公式サイトのGETTING STARTのINSTALL SWIFTに従います。

# Linuxへのインストールの公式情報は以下です。
# https://www.swift.org/install/linux/tarball/

# 公式 1. Install required dependencies:
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

# 公式 2. Download the latest binary release (6.0.2).
curl -s -O \
  $SWIFT_TAR_BALL_URL

# 公式 3. Import and verify the PGP signature:
# $ gpg --keyserver hkp://keyserver.ubuntu.com \
#           --recv-keys \
#           'A62A E125 BBBF BB96 A6E0  42EC 925C C1CC ED3D 1561'\
#           'E813 C892 820A 6FA1 3755  B268 F167 DF1A CF9C E069'
# この手順は省略します

# 公式 4. Extract the archive with the following command:
tar xzf $SWIFT_TAR_BALL_FILE

# 公式 5. Add the Swift toolchain to your path as follows:
# $ export PATH=/path/to/usr/bin:"${PATH}"
# 他の言語環境への影響が不明な為、省略します。

# 公式のインストール手順は以上です

# インストール結果を確認します
$SWIFT --version

# Static Linux SDKの公式情報は、以下です
# https://www.swift.org/documentation/articles/static-linux-getting-started.html

# Once that is out of the way, actually installing the Static Linux SDK is easy; at a prompt, enter
# の部分です

$SWIFT \
 sdk install \
 $STATIC_LINUX_SDK_URL
  --checksum $STATIC_LINUX_SDK_CHECKSUM

# Swift will download and install the SDK on your system. You can get a list of installed SDKs with
# の部分です
# SDKのインストール結果を確認します
$SWIFT sdk list

# SDKのインストールは以上です
# AtCoderからの要請で不要なファイルを削除するよう指示があるため、ダウンロードしたファイルを削除します
rm $SWIFT_TAR_BALL_FILE
# これで言語環境の構築は完了しました

# 続いて、コンパイル環境の構築を行います
# コンパイル環境の構築では、AtCoderで使用するSwiftパッケージの初期化と依存パッケージの追加、そして事前ビルドを行います

# ジャッジがビルドを行う作業パッケージの初期化を行います。パッケージ名はMain、実行可能なプログラムとして初期化します
$SWIFT package init --name Main --type executable

# Package.swiftを更新し、AtCoderで使用する依存パッケージを作業パッケージに追加します
cat << 'EOF' > Package.swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "Main",
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      from: "1.1.4"),
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      from: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-numerics",
      // Commit e30276b
      branch: "main"),
    .package(
      url: "https://github.com/apple/swift-atomics",
      from: "1.2.0"),
    .package(
      url: "https://github.com/apple/swift-system",
      from: "1.4.0"),
    .package(
      url: "https://github.com/attaswift/BigInt.git",
      from: "5.5.0"),
    .package(
      url: "https://github.com/dankogai/swift-bignum.git",
      from: "5.4.1"),
    .package(
      url: "https://github.com/davecom/SwiftGraph",
      from: "3.1.0"),
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // Commit 4cfbc16
      branch: "main"),
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      from: "0.0.3"),
    .package(
      url: "https://github.com/narumij/swift-tree",
      from: "0.0.3"),
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
        .product(name: "AcCollections", package: "swift-tree"),
      ],
      path: "Sources"
    )
  ]
)
EOF

# 念の為に、クリーニングします
$SWIFT package clean

# 依存パッケージの解決とパッケージのビルドを事前に行います
$SWIFT build -c release --swift-sdk x86_64-swift-linux-musl

# ジャッジによるビルド判定が正しく行われるよう、ビルド結果を削除します
# 標準的なパスは、.build/release/Mainですが、
# .build/release/が、Static Linux SDKの影響で、
# .build/x86_64-swift-linux-musl/release/へのシンボリックリンクとなっています
# Static Linux SDKのInstructionに載っている方を採用し、直接削除します
rm .build/x86_64-swift-linux-musl/release/Main
