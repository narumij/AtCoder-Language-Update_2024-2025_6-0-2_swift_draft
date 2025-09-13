#!/bin/bash

# 「私は強制プッシュをしました」
export SWIFT_AC_LIBRARY_USES_O_UNCHECKED=true
export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

PACKAGE_NAME="Executable"
PACKAGE_PATH="$(pwd)/${PACKAGE_NAME}"
SOURCE_PATH="$(pwd)/${PACKAGE_NAME}/Sources/main.swift"
FILE="${PACKAGE_PATH}/.build/release/Main"

echo "Heap size: $(ulimit -v)"
echo "Stack size: $(ulimit -s)"

rm $FILE
echo 'check 1) ############'
echo 'cat ./Script/build.sh' | bash
echo 'check 2) ############'
echo 'cat ./Script/build.sh | bash' | bash
echo 'check 3) ############'
echo $(tq 'compile' --file dist/swift.toml)
echo 'check 4) ############'
echo $(tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//")
echo 'check 5) ############'
echo $(tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//")

echo '00) ############'

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash

echo "終了コード: $?"

# cleanするとpunirun方式は壊れる

# echo '000) ############'

# swift package clean

# tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash

# echo "終了コード: $?"

echo '0) ############'

rm $FILE
cp test/main.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              
#tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              
# bash Script/build.sh

echo `pwd`
ls -al ./Script/build.sh
ls -al /home/runner/work/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/Script/build.sh
# ls -al ./work/compile.sh

cat ./Script/build.sh | bash

cat << 'EOF' | $FILE
3
1 2 3
EOF

echo '1) ############'

rm $FILE
cp test/abc235_d/main.1.swift $SOURCE_PATH
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              
$FILE < test/abc235_d/sample-x.in

echo '2) ############'

rm $FILE
cp test/abc235_d/main.2.swift $SOURCE_PATH
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

time $FILE < test/abc235_d/sample-x.in

echo '3) crash twice ############'

rm $FILE
cp test/crash/crash1.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | $FILE
EOF

cp test/crash/crash2.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | $FILE
EOF

echo '4) compile error ############'

rm $FILE
cp test/compileError/main.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | $FILE
EOF

echo '5) ############'

rm $FILE
cp test/mainActor/main.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | $FILE
EOF

echo '6) ############'

rm $FILE
cp test/macro/main.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | $FILE
EOF

echo '7) ############'

rm $FILE
cp test/stdio/main.swift $SOURCE_PATH

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

echo "終了コード: $?"

cat << 'EOF' | $FILE
EOF
