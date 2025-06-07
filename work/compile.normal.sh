
. "$HOME/.local/share/swiftly/env.sh"

# 環境変数はtoml側で記述
# これがないとswift-ac-libraryのコンパイルが走ってしまう
# export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

swift \
  build \
  -c release

