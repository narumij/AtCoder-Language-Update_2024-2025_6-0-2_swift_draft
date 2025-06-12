
. "$HOME/.local/share/swiftly/env.sh"

# 環境変数はtoml側で記述
# これがないとswift-ac-libraryのコンパイルが走ってしまう
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
# 最終版では削ることを予定しています。

# swift build -c release
swift build --build-system swiftbuild -c release

# コンパイル所要時間の目安はhello wolrdで5秒程度。
# それを上回る場合、差分コンパイルに問題が生じている可能性があります。
