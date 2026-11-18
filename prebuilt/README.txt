事前コンパイル方式

対象は既存のSwift 6.2 / Ubuntu 24.04用ドラフトです。
Swiftパッケージの版と言語モードは旧dist/swift.tomlを引き継ぎます。
template/とwork/の過去の試行は、新しい構築には使用しません。

1. bash dist/install.sh
   SwiftツールチェーンとOSの開発パッケージを用意し、SwiftPMで
   JudgeLibrariesの静的アーカイブを一度だけビルドします。
   SwiftLibraries/にはSwiftモジュール、Cヘッダとmodule map、
   マクロ実行ファイル、ライセンス、依存ロックを配置します。

2. bash SwiftLibraries/compile.sh main.swift main
   提出コードをswiftcで直接コンパイルしてリンクします。
   提出時にSwiftPM、ネットワーク、prebuilt/.buildは使用しません。
   コンパイル失敗時には前の実行ファイルを残しません。
   @main形式を明示的に試す場合は末尾に-parse-as-libraryを渡せます。
   ジャッジの通常入口は従来同様、トップレベルコードのmain.swiftです。

3. bash test/test.sh
   事前配置した成果物だけで正常実行、マクロ、MainActor、標準入出力、
   コンパイルエラー、実行時エラー、繰り返しコンパイルを検証します。
   CIではprebuilt/.buildとマニフェストを外してから検証します。

Package.swift / Package.resolvedは採用する依存バージョンの正本です。
変更後はbash prebuilt/render.shで配布用dist/swift.tomlを更新します。
CIは配布用TOMLのinstall・compile・executionも実際に使用します。
SwiftLibraries/は同一ツールチェーン・同一設置先で使う成果物です。
異なるSwift版や設置先への移設時には再構築してください。

CIでのUbuntu実行結果はまだ未確認です。ローカルのMacでは構文検査、
依存解決、最小のSwift/C事前ビルド成果物を使ったコンパイル経路を確認済みです。
OSの開発パッケージはUbuntuの更新版を使用し、CIで実際の版を記録します。
