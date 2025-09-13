
# 現在の公式手順、swiftlyを利用したインストール方法に問題が生じたため、
# 旧公式手順に従ってインストールを行います。
# Alternate Install Options > Tarball > Instruction
# https://www.swift.org/install/linux/tarball/

NUMBER="6.1.3"
VERSION="${NUMBER}-RELEASE"
PLATFORM="ubuntu24.04"
TAR_FILE="swift-${VERSION}-${PLATFORM}.tar.gz"
# https://download.swift.org/swift-6.1.3-release/ubuntu2404/swift-6.1.3-RELEASE/swift-6.1.3-RELEASE-ubuntu24.04.tar.gz
TAR_URL="https://download.swift.org/swift-${NUMBER}-release/$(echo $PLATFORM | tr -d .)/swift-${VERSION}/${TAR_FILE}"

SWIFT_COMMAND_PATH="$(pwd)/swift-${VERSION}-${PLATFORM}/usr/bin/swift"

PACKAGE_NAME="Executable"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"
FILE="${PACKAGE_PATH}/.build/release/Main"

echo "Current directory: $(pwd)"
echo "Swift Command Path: ${SWIFT_COMMAND_PATH}"
echo "Download URL: ${TAR_URL}"

export DEBIAN_FRONTEND=noninteractive

# 一部のパッケージで-Ouncheckedを使用するように設定します
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
export SWIFTPM_MAX_CONCURRENT_OPERATIONS=1
export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

sudo apt-get update

# このスクリプトでは、まず言語環境を構築し、その後ビルド環境を構築します。

# ここから、言語環境の構築を開始します。
# 言語環境の構築では、Swift toolchainの展開を行います。
# Swift toolchainの展開手順は、Swift公式サイトのGETTING STARTのINSTALL SWIFTに従います。

# Linuxへのインストールの公式情報は以下です。
# https://www.swift.org/install/linux/tarball/

# 公式 1. Install required dependencies:
sudo apt-get install -y \
             binutils \
             git \
             gnupg2 \
             libc6-dev \
             libcurl4-openssl-dev \
             libedit2 \
             libgcc-13-dev \
             libncurses-dev \
             libpython3-dev \
             libsqlite3-0 \
             libstdc++-13-dev \
             libxml2-dev \
             libz3-dev \
             pkg-config \
             tzdata \
             unzip \
             zlib1g-dev

# 公式 2. Download the latest binary release.
curl -s -O $TAR_URL

# 公式 3. Import and verify the PGP signature:
# $ gpg --keyserver hkp://keyserver.ubuntu.com \
#           --recv-keys \
#           'A62A E125 BBBF BB96 A6E0  42EC 925C C1CC ED3D 1561'\
#           'E813 C892 820A 6FA1 3755  B268 F167 DF1A CF9C E069'
# この手順は省略します

# 公式 4. Extract the archive with the following command:
tar xzf $TAR_FILE

# 公式 5. Add the Swift toolchain to your path as follows:
# $ export PATH=/path/to/usr/bin:"${PATH}"
# GitHub Actionsでの動作確認で、別のバイナリが実行されてしまい確認にならないため、実行パスの指定は直接行います

# 公式のインストール手順は以上です

# バージョン番号を出力し、ログでも処理系バージョンを確認する
${SWIFT_PATH}/swift --version

# 運営からの不要なファイル削除に関する指示に従い、ダウンロードしたファイルを削除します
rm $TAR_FILE

ls -al

# accelerate-linuxのビルドに必要なパッケージをインストールします
sudo apt-get install -y \
  "libopenblas-dev=0.3.26+ds-1" \
  "libopenblas0=0.3.26+ds-1" \
  "libopenblas-pthread-dev=0.3.26+ds-1" \
  "libopenblas0-pthread=0.3.26+ds-1" \
  "liblapacke-dev=3.12.0-3build1.1" \
  "liblapacke=3.12.0-3build1.1" \
  "libtmglib-dev=3.12.0-3build1.1" \
  "libtmglib3=3.12.0-3build1.1"

# これで言語環境の構築は完了しました

# 続いて、コンパイル環境の構築を行います
# コンパイル環境の構築では、AtCoderで使用するSwiftパッケージの初期化と依存パッケージの追加、そして事前ビルドを行います

mkdir -p $PACKAGE_NAME

cd $PACKAGE_NAME

# ジャッジがビルドを行う作業パッケージの初期化を行います。パッケージ名はMain、実行可能なプログラムとして初期化します
${SWIFT_COMMAND_PATH} package init --name Main --type executable

# Package.swiftを更新し、AtCoderジャッジで使用する依存パッケージを作業パッケージに追加します
cat << 'EOF' > Package.swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "Main",
  // @MainActorとRegexとType PackをmacOSローカルでパッケージを利用する場合に必要な設定値
  platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
  dependencies: [
    // swift 5.8.1時点での既存ライブラリです
    .package(
      url: "https://github.com/apple/swift-collections",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリです。
    .package(
      url: "https://github.com/apple/swift-algorithms",
      exact: "1.2.1"),
    // swift 5.8.1時点での既存ライブラリで、実数及び複素数です。
    .package(
      url: "https://github.com/apple/swift-numerics",
      exact: "1.1.0"),
    // 多倍長整数です。
    .package(
      url: "https://github.com/attaswift/BigInt",
      exact: "5.7.0"),
    // 有理数です。
    // インストール手順がmainブランチ指定だったので、tagではなくrevision指定にしています。
    .package(
      url: "https://github.com/dankogai/swift-bignum",
      revision: "a562275f0a64bc95f6e3f6c45ee652eefa820749"),
    // SIMDです。
    .package(
      url: "https://github.com/keyvariable/kvSIMD.swift",
      exact: "1.1.0"),
    // BLAS及びLAPACKです。
    .package(
      url: "https://github.com/brokenhandsio/accelerate-linux",
      revision: "8eda308ea3129130e90e5c01fc437a4c5d2ca278"),
    // Atcoder LibraryのSwift版です。
    .package(
      url: "https://github.com/narumij/swift-ac-library",
      // -Ouncheckedを利用するためにrevision指定としている
      // tag - 0.1.29
      revision: "528c893e8d9b74acbfd455781e9a4bb6c5a5a262"),
    // 高速な入力、二分探索、その他便利関数です。
    .package(
      url: "https://github.com/narumij/swift-ac-foundation",
      // .unsafeFlags(["-std=c++17"])に対するビルド拒否を迂回するため、revision指定としている
      // branch - main
      revision: "3d7c910ca017fba151c61d40a4c6a383702b4b97"),
    // 平衡二分探索木と順列全列挙です。
    .package(
      url: "https://github.com/narumij/swift-ac-collections",
      exact: "0.1.44"),
    // メモ化マクロです。
    .package(
      url: "https://github.com/narumij/swift-ac-memoize",
      exact: "0.1.11"),
  ],
  targets: [
    .executableTarget(
      name: "Main",
      dependencies: [
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "Numerics", package: "swift-numerics"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "BigNum", package: "swift-bignum"),
        .product(name: "kvSIMD", package: "kvSIMD.swift"),
        .product(name: "AccelerateLinux", package: "accelerate-linux"),
        .product(name: "AtCoder", package: "swift-ac-library"),
        .product(name: "AcFoundation", package: "swift-ac-foundation"),
        .product(name: "AcCollections", package: "swift-ac-collections"),
        .product(name: "AcMemoize", package: "swift-ac-memoize"),
      ],
      path: "Sources",
      swiftSettings: [
        .define("ONLINE_JUDGE")
      ]
    )
  ]
)
EOF

# 念の為に、クリーニングします
${SWIFT_COMMAND_PATH} package clean

# 依存パッケージの解決を行います
${SWIFT_COMMAND_PATH} package resolve

# 実行可能パッケージのビルドを行います
# --product Mainは、observabilityScope制限の為に付与
# --static-swift-stdlibは、Swift stdlibで静的リンクを行うオプション
# --enable-experimental-prebuiltsは事前ビルド済みのswift-syntaxを利用するために付与, 6.2以降でデフォルトになる
# --build-system nativeは、6.2になった場合の変動を避けるために付与
# --jobs 1は、CPU数の変動によるフルビルドを迂回するために付与
# --configuration releaseは、リリースビルドを行うためのオプション
# 1>&2は、標準出力を標準エラーにリダイレクトするためのもので、既存由来
# |& tee /dev/nullは、環境情報収集に関してSPMにバグがあり、そのワークアラウンド
# ビルドオプションが変化するとフルビルドとなるため、コンパイルスクリプトと揃える必要がある
${SWIFT_COMMAND_PATH} \
  build \
  --product Main \
  --static-swift-stdlib \
  --enable-experimental-prebuilts \
  --build-system native \
  --jobs 1 \
  --configuration release \
  1>&2 \
  |& tee /dev/null

cd ../

tar czf build-cache.tgz $PACKAGE_PATH/.build

# コンパイルに失敗した場合、インストール失敗とする
if [ ! -f "$FILE" ]; then
  echo "Error: 初回のビルドに失敗しました: $FILE" >&2
  exit 1
fi

# Hello, world!を出力
$FILE

# ジャッジによるビルド判定が正しく行われるよう、ビルド結果を削除します
rm $FILE
