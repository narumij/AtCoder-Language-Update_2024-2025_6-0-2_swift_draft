
export DEBIAN_FRONTEND=noninteractive
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
export SWIFTPM_MAX_CONCURRENT_OPERATIONS=1
export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

PACKAGE_NAME="Executable"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"

FILE="${PACKAGE_PATH}/.build/release/Main"

bash ./Script/build.sh

if [ ! -f "$FILE" ]; then
  echo "Error: Failed to build file '$FILE'" >&2
  exit 1
fi
