
NUMBER="6.2"
VERSION="${NUMBER}-RELEASE"
PLATFORM="ubuntu24.04"
SWIFTC_COMMAND_PATH="$(pwd)/swift-${VERSION}-${PLATFORM}/usr/bin/swiftc"
SWIFT_COMMAND_PATH="$(pwd)/swift-${VERSION}-${PLATFORM}/usr/bin/swift"

export DEBIAN_FRONTEND=noninteractive
# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
export SWIFTPM_MAX_CONCURRENT_OPERATIONS=1
export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

PACKAGE_NAME="Package"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"
EXECUTABLE_PATH="${PACKAGE_PATH}/.build/release/Main"

SCRIPT_DIRECTORY="Script"
SCRIPT_DIRECTORY_PATH="$(pwd)/${SCRIPT_DIRECTORY}"
SCRIPT_PATH="${SCRIPT_DIRECTORY_PATH}/build.sh"

# 差分コンパイルのログから抽出したコンパイルコマンドを実行します
${SWIFTC_COMMAND_PATH} -module-name Main -emit-dependencies -emit-module -emit-module-path ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Modules/Main.swiftmodule -output-file-map ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Main.build/output-file-map.json -whole-module-optimization -num-threads 1 -c @${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Main.build/sources -I ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Modules -target x86_64-unknown-linux-gnu -whole-module-optimization -num-threads 1 -serialize-diagnostics -O -j1 -DSWIFT_PACKAGE -DSWIFT_MODULE_RESOURCE_BUNDLE_UNAVAILABLE -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/checkouts/swift-numerics/Sources/_NumericsShims/include/module.modulemap -Xcc -I -Xcc ${PACKAGE_PATH}/.build/checkouts/swift-numerics/Sources/_NumericsShims/include -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/checkouts/accelerate-linux/Sources/CLAPACK/module.modulemap -I/usr/include/x86_64-linux-gnu -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/checkouts/accelerate-linux/Sources/CBLAS/module.modulemap -I/usr/include/x86_64-linux-gnu/openblas-pthread -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/_MT19937.build/module.modulemap -Xcc -I -Xcc ${PACKAGE_PATH}/.build/checkouts/swift-ac-foundation/Sources/_MT19937/include -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/_cxx.build/module.modulemap -Xcc -I -Xcc ${PACKAGE_PATH}/.build/checkouts/swift-ac-foundation/Sources/_cxx/include -Xcc -fmodule-map-file=${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/_FastIO.build/module.modulemap -Xcc -I -Xcc ${PACKAGE_PATH}/.build/checkouts/swift-ac-foundation/Sources/_FastIO/include -module-cache-path ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/ModuleCache  -Xfrontend -entry-point-function-name -Xfrontend Main_main -swift-version 6 -DONLINE_JUDGE -default-isolation nonisolated -g -Xcc -fPIC -Xcc -g -package-name package -Xfrontend -load-plugin-executable -Xfrontend ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/swift-ac-memoizeMacros-tool#swift_ac_memoizeMacros -Xcc -fno-omit-frame-pointer
${SWIFTC_COMMAND_PATH} -L/usr/lib/x86_64-linux-gnu -llapacke -L/usr/lib/x86_64-linux-gnu/openblas-pthread -lopenblas -lstdc++ -L ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release -o ${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Main -module-name Main -emit-executable -Xlinker --gc-sections -Xlinker --defsym -Xlinker main=Main_main -Xlinker '-rpath=$ORIGIN' @${PACKAGE_PATH}/.build/x86_64-unknown-linux-gnu/release/Main.product/Objects.LinkFileList -target x86_64-unknown-linux-gnu -lm -g

# (抽出スクリプトでビルドする場合)
# bash $SCRIPT_PATH 1>&2

# (swiftコマンドでビルドする場合)
# ビルドオプションが変化するとフルビルドとなるため、インストールスクリプトと揃える必要がある
# ${SWIFT_COMMAND_PATH} \
#   build \
#   --product Main \
#   --build-system native \
#   --jobs 1 \
#   --configuration release \
#   --package-path $PACKAGE_PATH \
#   |& tee /dev/null

if [ ! -f "$EXECUTABLE_PATH" ]; then
  echo "Error: Failed to build file '$EXECUTABLE_PATH'" >&2
  exit 1
fi
