
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true

bash ./Script/build.sh

if [ ! -f "$FILE" ]; then
  echo "Error: ビルドに失敗しました: $FILE" >&2
  exit 1
fi
