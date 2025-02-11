#!/bin/bash

# 「私は強制プッシュをしました」

echo "Heap size: $(ulimit -v)"
echo "Stack size: $(ulimit -s)"

rm .build/release/Main
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
echo '0) ############'

rm .build/release/Main
cp test/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              
#tq 'compile' --file dist/swift.toml | sed -e "1s/^'''//" -e "\$s/'''$//" | bash              
# bash Script/build.sh

echo `pwd`
ls -al ./Script/build.sh
ls -al /home/runner/work/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/AtCoder-Language-Update_2024-2025_6-0-2_swift_draft/Script/build.sh
ls -al ./work/compile.sh

cat ./Script/build.sh | bash

cat << 'EOF' | .build/release/Main
3
1 2 3
EOF

echo '1) ############'

rm .build/release/Main
cp test/abc235_d/main.1.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              
.build/release/Main < test/abc235_d/sample-x.in

echo '2) ############'

rm .build/release/Main
cp test/abc235_d/main.2.swift Sources/main.swift
# ./${SWIFT_TAR_BALL}/usr/bin/swift package clean
tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

time .build/release/Main < test/abc235_d/sample-x.in

export SWIFT_BACKTRACE='enable=yes,output-to=stderr,interactive=no'

echo '3) ############'

rm .build/release/Main
cp test/crash/crash1.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

cp test/crash/crash2.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

echo '4) ############'

rm .build/release/Main
cp test/mainActor/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

echo '5) ############'

rm .build/release/Main
cp test/macro/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

echo '6) ############'

rm .build/release/Main
cp test/stdio/main.swift Sources/main.swift

tq 'compile' --file dist/swift.toml | sed -E -e "1s/^('''|\"\"\")//" -e "\$s/('''|\"\"\")\$//" | bash              

cat << 'EOF' | .build/release/Main
EOF

