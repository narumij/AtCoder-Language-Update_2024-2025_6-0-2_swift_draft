NUMBER="6.1.3"
VERSION="${NUMBER}-RELEASE"
PLATFORM="ubuntu24.04"
SWIFT_PATH="swift-${VERSION}-${PLATFORM}/usr/bin"

# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

export DUMMY_ENV_KEY="DUMMY_ENV_VALUE"

# ビルドオプションが変化するとフルビルドとなるため、インストールスクリプトと揃える必要がある
./${SWIFT_PATH}/swift \
  build \
  --product Main \
  --static-swift-stdlib \
  --enable-experimental-prebuilts \
  --build-system native \
  --jobs 1 \
  --skip-update \
  -c release \
  1>&2 \
  |& tee /dev/null

# コンパイル所要時間の目安はhello wolrdで5秒程度。
# それを上回る場合、差分コンパイルに問題が生じている可能性があります。

FILE=".build/release/Main"

if [ ! -f "$FILE" ]; then
  echo "Error: Failed to build file '$FILE'" >&2
  exit 1
fi