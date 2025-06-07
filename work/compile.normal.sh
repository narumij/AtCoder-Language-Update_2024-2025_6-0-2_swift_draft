
. "$HOME/.local/share/swiftly/env.sh"
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

swift \
  build \
  -c release \
  1>&2 |& tee /dev/null

