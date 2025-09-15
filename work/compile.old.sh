
PACKAGE_NAME="Package"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"
EXECUTABLE_PATH="${PACKAGE_PATH}/.build/release/Main"

SCRIPT_DIRECTORY="Script"
SCRIPT_DIRECTORY_PATH="$(pwd)/${SCRIPT_DIRECTORY}"
SCRIPT_PATH="${SCRIPT_DIRECTORY_PATH}/build.sh"

bash $SCRIPT_PATH 1>&2

if [ ! -f "$EXECUTABLE_PATH" ]; then
  echo "Error: Failed to build file '$EXECUTABLE_PATH'" >&2
  exit 1
fi
