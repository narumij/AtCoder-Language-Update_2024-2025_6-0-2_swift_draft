
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

FILE=".build/release/Main"

bash ./Script/build.sh

if [ ! -f "$FILE" ]; then
  echo "Error: Failed to build file '$FILE'" >&2
  exit 1
fi
