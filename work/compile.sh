
PLATFORM=ubuntu24.04
LANG_VERSION=6.0.3
OS_ARCH_SUFFIX="" # arm64等の場合に指定する

SWIFT_VERSION=swift-${LANG_VERSION}-RELEASE
SWIFT_TAR_BALL="$SWIFT_VERSION-$PLATFORM$OS_ARCH_SUFFIX"

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

./${SWIFT_TAR_BALL}/usr/bin/swift \
    build \
    -c release \
    --Xswiftc -num-threads --Xswiftc 1 --Xswiftc -j --Xswiftc 1 \
    1>&2 |& tee /dev/null
