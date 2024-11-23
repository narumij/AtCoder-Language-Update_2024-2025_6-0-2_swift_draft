#!/bin/sh

./swift-6.0.2-RELEASE-ubuntu24.04/usr/bin/swift \
    build -c \
    release --swift-sdk \
    x86_64-swift-linux-musl \
    1>&2
