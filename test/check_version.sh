#!/bin/bash

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.3
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"

# TOMLファイルとキーを指定
TOML_FILE="dist/swift.toml"
TOML_KEY="version"

# TOMLファイルからバージョンを取得
TOML_VERSION=$(tq "$TOML_KEY" --file "$TOML_FILE" | sed -e "s/^'//" -e "s/'$//")

# インストール済みのSwiftバージョンを取得（正確に抽出）
INSTALLED_VERSION=$(./${SWIFT_TAR_BALL}/usr/bin/swift --version | awk '/Swift version/ {print $3}')

# バージョンの比較
if [ "$TOML_VERSION" = "$INSTALLED_VERSION" ]; then
    echo "Swift versions match: $TOML_VERSION"
    exit 0
else
    echo "Swift version mismatch! TOML: $TOML_VERSION, Installed: $INSTALLED_VERSION"
    exit 1
fi
