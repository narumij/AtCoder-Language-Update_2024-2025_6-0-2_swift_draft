#!/bin/sh

sudo apt update
export DEBIAN_FRONTEND=noninteractive

## (6.0.2) 修正箇所
## don't use apt!
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

## (6.0.2) 修正箇所:レビュー指摘で22を24に修正、内容については前回の内容であり、ubuntu22での記述であることに留意
## (6.0.2) libpython3.8について、6.0.2の公式にはないものなので、apt-getに関する記述のみが有効？
## (6.0.2) 最終版では、このコメントは消してもよさそう
## 依存packagesの公式インストール方法だが、libpython3.8がデフォルトでubuntu24ではapt repositoryに存在しない。
## aptだと一つでも存在しなかったらエラーで強制終了するため、apt-getにしている。libpython3.8の行を消してもいいかも。
## libpython3.8はなくても問題ないことを確認済み。

## (6.0.2) 修正箇所
export SWIFT_PLATFORM=ubuntu24.04
## (6.0.2) 修正箇所
export SWIFT_VERSION_NUMBER=6.0.2
export SWIFT_BRANCH=swift-$SWIFT_VERSION_NUMBER-release
export SWIFT_VERSION=swift-$SWIFT_VERSION_NUMBER-RELEASE
export SWIFT_WEBROOT=https://download.swift.org

## check architecture
## CPUなど低レイヤーの環境が不明のため。
set -e
ARCH_NAME="$(dpkg --print-architecture)"
url=
case "${ARCH_NAME##*-}" in
'amd64')
OS_ARCH_SUFFIX=''
;;
'arm64')
OS_ARCH_SUFFIX='-aarch64'
;;
*)
echo >&2 "error: unsupported architecture: '$ARCH_NAME'"
exit 1
;;
esac

export SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $SWIFT_PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
export FILE_NAME="$SWIFT_VERSION-$SWIFT_PLATFORM$OS_ARCH_SUFFIX"
export SWIFT_BIN_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$FILE_NAME.tar.gz"

sudo apt install -y wget

wget -O - "$SWIFT_BIN_URL" | sudo tar -xzC /usr/local/ \
--transform=s/$FILE_NAME/swift/

## echo 'export PATH=/usr/local/swift/usr/bin:$PATH' >>~/.bashrc

## verify swift command.
## source ~/.bashrc
export PATH=/usr/local/swift/usr/bin:$PATH
swift --version
## 正しく表示されればswiftcも使えます。

## (6.0.2) 追加箇所
swift sdk \
  install https://download.swift.org/swift-6.0.2-release/static-sdk/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE_static-linux-0.0.1.artifactbundle.tar.gz \
  --checksum aa5515476a403797223fc2aad4ca0c3bf83995d5427fb297cab1d93c68cee075

swift sdk list

## create project
## mkdir swift
## cd swift
swift package init --name Main --type executable
## (6.0.2) 修正箇所
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
## install library
swift build -Xswiftc -O -Xlinker -lm -c release --swift-sdk x86_64-swift-linux-musl
rm .build/release/Main