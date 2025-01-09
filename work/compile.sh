#!/bin/sh

PLATFORM=ubuntu24.04
LANG_VERSION=6.0.3
OS_ARCH_SUFFIX="" # arm64等の場合に指定する
CURRENT_DIR=${pwd}

SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"

export PATH=${CURRENT_DIR}/${SWIFT_TAR_BALL}/usr/bin/swift:"${PATH}"

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

swift build -c release -j $(nproc) 1>&2
