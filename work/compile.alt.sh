PLATFORM=ubuntu24.04
LANG_VERSION=6.1.2
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_BRANCH=swift-${LANG_VERSION}-release
SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_WEBROOT=https://download.swift.org
SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"
SWIFT_TAR_BALL_URL="$SWIFT_WEBDIR/$SWIFT_VERSION/$SWIFT_TAR_BALL.tar.gz"

# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

./${SWIFT_TAR_BALL}/usr/bin/swift build -c release

# コンパイル所要時間の目安はhello wolrdで5秒程度。
# それを上回る場合、差分コンパイルに問題が生じている可能性があります。
