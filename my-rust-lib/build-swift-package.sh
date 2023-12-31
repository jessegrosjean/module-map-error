# build-rust.sh

#!/bin/bash

set -e

THISDIR=$(dirname $0)
cd $THISDIR

# Build the project for the desired platforms:
cargo build --target x86_64-apple-darwin
cargo build --target aarch64-apple-darwin
mkdir -p ./target/universal-macos/debug

lipo \
    ./target/aarch64-apple-darwin/debug/libmy_rust_lib.a \
    ./target/x86_64-apple-darwin/debug/libmy_rust_lib.a -create -output \
    ./target/universal-macos/debug/libmy_rust_lib.a

cargo build --target aarch64-apple-ios

cargo build --target x86_64-apple-ios
cargo build --target aarch64-apple-ios-sim
mkdir -p ./target/universal-ios/debug

lipo \
    ./target/aarch64-apple-ios-sim/debug/libmy_rust_lib.a \
    ./target/x86_64-apple-ios/debug/libmy_rust_lib.a -create -output \
    ./target/universal-ios/debug/libmy_rust_lib.a

swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir MySwiftPackage \
  --ios target/aarch64-apple-ios/debug/libmy_rust_lib.a \
  --simulator target/universal-ios/debug/libmy_rust_lib.a \
  --macos target/universal-macos/debug/libmy_rust_lib.a \
  --name MySwiftPackage
