#!/bin/sh

export PATH=/usr/local/swift/usr/bin:$PATH
swift build -Xswiftc -O -Xlinker -lm -c release 1>&2

swift run --configuration release Main
