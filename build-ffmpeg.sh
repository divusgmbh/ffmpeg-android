#!/bin/bash

set -e

ANDROID_TC="/ndk/toolchain-android-r10e"
OUT_DIR="/out/ffmpeg-4.0-arm"
PKG_CONFIG="../ffmpeg-pkg-config"

mkdir -p ${OUT_DIR}
cd /ffmpeg/FFmpeg-release-4.0

echo "Configuring ffmpeg..."
./configure --target-os=linux \
	--cross-prefix=${ANDROID_TC}/bin/arm-linux-androideabi- \
	--arch=arm \
	--cpu=cortex-a8 \
	--enable-runtime-cpudetect \
	--sysroot=${ANDROID_TC}/sysroot \
	--prefix=${OUT_DIR} \
	--extra-ldflags='-pie' \
	--pkg-config=${PKG_CONFIG} \
	--pkg-config-flags="--static" \
	--enable-static

echo "Building ffmpeg..."
make -j

echo "Installing ffmpeg..."
make install

echo "Creating output archive..."
cd /out
tar cvfz ffmpeg-4.0-arm.tar.gz ffmpeg-4.0-arm

echo "Done!"
