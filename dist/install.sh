#!/bin/bash

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.3
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_BRANCH=swift-${LANG_VERSION}-release
SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_WEBROOT=https://download.swift.org
SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"
SWIFT_TAR_BALL_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$SWIFT_TAR_BALL.tar.gz"

export DEBIAN_FRONTEND=noninteractive

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

sudo apt-get update

# このスクリプトでは、まず言語環境を構築し、その後ビルド環境を構築します。

# ここから、言語環境の構築を開始します。
# 言語環境の構築では、Swift toolchainの展開を行います。
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

# 公式 2. Download the latest binary release.
curl -s -O $SWIFT_TAR_BALL_URL

# 公式 3. Import and verify the PGP signature:
# $ gpg --keyserver hkp://keyserver.ubuntu.com \
#           --recv-keys \
#           'A62A E125 BBBF BB96 A6E0  42EC 925C C1CC ED3D 1561'\
#           'E813 C892 820A 6FA1 3755  B268 F167 DF1A CF9C E069'
# この手順は省略します

# 公式 4. Extract the archive with the following command:
tar xzf $SWIFT_TAR_BALL.tar.gz

# 公式 5. Add the Swift toolchain to your path as follows:
# $ export PATH=/path/to/usr/bin:"${PATH}"
# GitHub Actionsでの動作確認で、別のバイナリが実行されてしまい確認にならないため、実行パスの指定は直接行います

# 公式のインストール手順は以上です

# バージョン番号を出力し、ログでも処理系バージョンを確認する
./${SWIFT_TAR_BALL}/usr/bin/swift --version

# AtCoderからの要請で不要なファイルを削除するよう指示があるため、ダウンロードしたファイルを削除します
rm $SWIFT_TAR_BALL.tar.gz
# これで言語環境の構築は完了しました

# 続いて、コンパイル環境の構築を行います
# コンパイル環境の構築では、AtCoderで使用するSwiftパッケージの初期化と依存パッケージの追加、そして事前ビルドを行います

# ジャッジがビルドを行う作業パッケージの初期化を行います。パッケージ名はMain、実行可能なプログラムとして初期化します
./${SWIFT_TAR_BALL}/usr/bin/swift package init --name Main --type executable

# Package.swiftを更新し、AtCoderジャッジで使用する依存パッケージを作業パッケージに追加します
cat << 'EOF' > Package.swift
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
EOF

# 念の為に、クリーニングします
./${SWIFT_TAR_BALL}/usr/bin/swift package clean

# 依存パッケージの解決とパッケージのビルドを事前に行います
./${SWIFT_TAR_BALL}/usr/bin/swift \
  build \
  -c release \
  1>&2 |& tee /dev/null

# ジャッジによるビルド判定が正しく行われるよう、ビルド結果を削除します
rm .build/release/Main
