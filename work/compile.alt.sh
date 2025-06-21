NUMBER="6.1.2"
VERSION="${NUMBER}-RELEASE"
PLATFORM="ubuntu24.04"
SWIFT_PATH="swift-${VERSION}-${PLATFORM}/usr/bin"

# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

./${SWIFT_PATH}/swift build -c release

# コンパイル所要時間の目安はhello wolrdで5秒程度。
# それを上回る場合、差分コンパイルに問題が生じている可能性があります。
