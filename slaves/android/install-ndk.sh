#!/bin/sh

set -ex

# Prep the Android NDK
#
# See https://github.com/servo/servo/wiki/Building-for-Android
curl -O http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip
unzip -q android-ndk-r11c-linux-x86_64.zip
bash android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
        --platform=android-9 \
        --toolchain=arm-linux-androideabi-4.9 \
        --install-dir=/android/ndk-arm-9 \
        --ndk-dir=/android/android-ndk-r11c \
        --arch=arm
# NB: this arm toolchain is used for testing the libc crate to ensure it
# works against the most recent version of android.  It cannot be combined
# with the previous toolchain!
bash android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
        --platform=android-21 \
        --toolchain=arm-linux-androideabi-4.9 \
        --install-dir=/android/ndk-arm \
        --ndk-dir=/android/android-ndk-r11c \
        --arch=arm
bash android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
        --platform=android-21 \
        --toolchain=aarch64-linux-android-4.9 \
        --install-dir=/android/ndk-aarch64 \
        --ndk-dir=/android/android-ndk-r11c \
        --arch=arm64
bash android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
        --platform=android-9 \
        --toolchain=x86-4.9 \
        --install-dir=/android/ndk-x86-9 \
        --ndk-dir=/android/android-ndk-r11c \
        --arch=x86
bash android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
        --platform=android-21 \
        --toolchain=x86_64-4.9 \
        --install-dir=/android/ndk-x86_64 \
        --ndk-dir=/android/android-ndk-r11c \
        --arch=x86_64

rm -rf ./android-ndk-r11c-linux-x86_64.zip ./android-ndk-r11c
