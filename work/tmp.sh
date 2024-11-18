#!/bin/sh

export SWIFT_PLATFORM=ubuntu24.04
export SWIFT_VERSION_NUMBER=6.0.2
export SWIFT_BRANCH=swift-$SWIFT_VERSION_NUMBER-release
export SWIFT_VERSION=swift-$SWIFT_VERSION_NUMBER-RELEASE
export SWIFT_WEBROOT=https://download.swift.org

OS_ARCH_SUFFIX=''

export SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $SWIFT_PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
export FILE_NAME="$SWIFT_VERSION-$SWIFT_PLATFORM$OS_ARCH_SUFFIX"
export SWIFT_BIN_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$FILE_NAME.tar.gz"

# sudo apt install -y wget

echo $SWIFT_BIN_URL
# 一致することを目視で確認済み
echo 'https://download.swift.org/swift-6.0.2-release/ubuntu2404/swift-6.0.2-RELEASE/swift-6.0.2-RELEASE-ubuntu24.04.tar.gz'

echo $FILE_NAME
