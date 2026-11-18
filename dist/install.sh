#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
prefix=${1:-"$root/SwiftLibraries"}
export DEBIAN_FRONTEND=noninteractive
if [[ $(uname -s) != Linux ]]; then
  echo 'The judge installation targets Ubuntu 24.04 Linux.' >&2
  exit 1
fi
sudo_cmd=()
if [[ $(id -u) != 0 ]]; then sudo_cmd=(sudo); fi
"${sudo_cmd[@]}" apt-get update
"${sudo_cmd[@]}" apt-get install -y curl ca-certificates git binutils libc6-dev libcurl4-openssl-dev libedit2 libgcc-13-dev libncurses-dev libpython3-dev libsqlite3-0 libstdc++-13-dev libxml2-dev libz3-dev pkg-config tzdata unzip zlib1g-dev libopenblas-dev liblapacke-dev python3
if [[ -z ${SWIFT:-} ]]; then
  archive=swift-6.2-RELEASE-ubuntu24.04
  toolchain="$root/$archive"
  if [[ ! -x "$toolchain/usr/bin/swift" ]]; then
    curl --fail --location --retry 3 "https://download.swift.org/swift-6.2-release/ubuntu2404/swift-6.2-RELEASE/$archive.tar.gz" -o "$root/$archive.tar.gz"
    tar -xzf "$root/$archive.tar.gz" -C "$root"
    rm "$root/$archive.tar.gz"
  fi
  export SWIFT="$toolchain/usr/bin/swift"
fi
"$SWIFT" --version
python3 "$root/prebuilt/build.py" "$root/prebuilt" "$prefix"
