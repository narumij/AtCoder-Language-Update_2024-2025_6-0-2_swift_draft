NUMBER="6.1.3"
VERSION="${NUMBER}-RELEASE"
PLATFORM="ubuntu24.04"
SWIFT_PATH="${pwd}/swift-${VERSION}-${PLATFORM}/usr/bin"

export DEBIAN_FRONTEND=noninteractive

# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
export SWIFTPM_MAX_CONCURRENT_OPERATIONS=1
export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

PACKAGE_NAME="Executable"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"

FILE="${PACKAGE_PATH}/.build/release/Main"

# tar xzf build-cache.tgz -C "$PACKAGE_PATH"

cd $PACKAGE_PATH

# ビルドオプションが変化するとフルビルドとなるため、インストールスクリプトと揃える必要がある
${SWIFT_PATH}/swift \
  build \
  --product Main \
  --static-swift-stdlib \
  --enable-experimental-prebuilts \
  --build-system native \
  --jobs 1 \
  --configuration release \
  1>&2 \
  |& tee /dev/null

# コンパイル所要時間の目安はhello wolrdで5秒程度。
# それを上回る場合、差分コンパイルに問題が生じている可能性があります。

cd ../

if [ ! -f "$FILE" ]; then
  echo "Error: Failed to build file '$FILE'" >&2
  exit 1
fi