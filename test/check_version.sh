#!/bin/bash

# TOMLファイルとキーを指定
TOML_FILE="dist/swift.toml"
TOML_KEY="version"

# TOMLファイルからバージョンを取得
TOML_VERSION=$(tq "$TOML_KEY" --file "$TOML_FILE" | sed -e "s/^'//" -e "s/'$//")

# インストール済みのSwiftバージョンを取得
INSTALLED_VERSION=$(swift --version | awk '{print $4}')

# バージョンの比較
if [ "$TOML_VERSION" = "$INSTALLED_VERSION" ]; then
    echo "Swift versions match: $TOML_VERSION"
    exit 0
else
    echo "Swift version mismatch! TOML: $TOML_VERSION, Installed: $INSTALLED_VERSION"
    exit 1
fi
