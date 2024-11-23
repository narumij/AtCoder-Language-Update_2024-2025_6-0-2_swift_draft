#!/bin/sh

# 公式情報参照先: https://www.swift.org/install/linux/tarball/

sudo apt update
export DEBIAN_FRONTEND=noninteractive

# 公式 1. Install required dependencies:

## (6.0.2) 修正箇所
## don't use apt!
sudo apt install -y \
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
wget -q https://download.swift.org/swift-6.0.2-release/ubuntu2404/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE-ubuntu24.04.tar.gz

# 公式 3. Import and verify the PGP signature:
# この手順は省略します

# 公式 4. Extract the archive with the following command:
tar xzf swift-6.0.2-RELEASE-ubuntu24.04.tar.gz

# 公式 5. Add the Swift toolchain to your path as follows:
# $ export PATH=/path/to/usr/bin:"${PATH}"
# 前回のやり取りの中で何か問題となっていたようなので、いったん行いません

# AtCoderからの要請で不要なファイルを削除するように指示があるため、削除する。
rm swift-6.0.2-RELEASE-ubuntu24.04.tar.gz

## echo 'export PATH=/usr/local/swift/usr/bin:$PATH' >>~/.bashrc

# ls ./

## verify swift command.
## source ~/.bashrc
# export PATH=/usr/local/swift/usr/bin:$PATH
./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift --version
## 正しく表示されればswiftcも使えます。

## (6.0.2) 追加箇所
./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift sdk \
  install https://download.swift.org/swift-6.0.2-release/static-sdk/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE_static-linux-0.0.1.artifactbundle.tar.gz \
  --checksum aa5515476a403797223fc2aad4ca0c3bf83995d5427fb297cab1d93c68cee075

./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift sdk list

## create project
## mkdir swift
## cd swift
./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift package init --name Main --type executable
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
#swift build -Xswiftc -O -Xlinker -lm -c release --swift-sdk x86_64-swift-linux-musl
./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift build -c release --swift-sdk x86_64-swift-linux-musl
rm .build/release/Main
