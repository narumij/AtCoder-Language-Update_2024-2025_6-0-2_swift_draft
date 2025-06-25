#!/bin/bash

PLATFORM=ubuntu24.04
LANG_VERSION=6.1.2
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

# これで言語環境の構築は完了しました

# 続いて、コンパイル環境の構築を行います
# コンパイル環境の構築では、AtCoderで使用するSwiftパッケージの初期化と依存パッケージの追加、そして事前ビルドを行います

# ジャッジがビルドを行う作業パッケージの初期化を行います。パッケージ名はMain、実行可能なプログラムとして初期化します
./${SWIFT_TAR_BALL}/usr/bin/swift package init --name Main --type executable

# Package.swiftを更新し、AtCoderジャッジで使用する依存パッケージを作業パッケージに追加します
cat << 'EOF' > Package.swift
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
      revision: "9fff582e068e1d2a4c0f92246a6143d94d40c63b"),
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
EOF

# ビルドスクリプトを配置するフォルダを作成
mkdir Script

# 念の為に、クリーニングします
./${SWIFT_TAR_BALL}/usr/bin/swift package clean

# 依存パッケージの解決とパッケージのビルドを事前に行います
./${SWIFT_TAR_BALL}/usr/bin/swift \
  build \
  --build-system native \
  -c release \
  -v 1>&2 |& tee /dev/null

# 差分コンパイルが行われるよう、ソースコードを変更します
sed -i 's/Hello/Hallo/' Sources/main.swift

# 差分コンパイルを実施し、ビルドログを取得します
./${SWIFT_TAR_BALL}/usr/bin/swift \
  build \
  --build-system native \
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

FILE=".build/release/Main"

if [ ! -f "$FILE" ]; then
  echo "Error: 初回のビルドに失敗しました: $FILE" >&2
  exit 1
fi

# Hello, world!を出力
$FILE

# ジャッジによるビルド判定が正しく行われるよう、ビルド結果を削除します
rm .build/release/Main
