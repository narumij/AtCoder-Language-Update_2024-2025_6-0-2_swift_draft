
. "$HOME/.local/share/swiftly/env.sh"

swift \
  build \
  -c release \
  1>&2 |& tee /dev/null

