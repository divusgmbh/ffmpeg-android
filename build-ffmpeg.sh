#!/bin/bash

set -e

FFMPEG_VERSION=4.0
ANDROID_TC="/ndk/toolchain-android-r10e"
OUT_DIR="/out/ffmpeg-${FFMPEG_VERSION}-arm"
PKG_CONFIG="../ffmpeg-pkg-config"
export API_LEVEL=14

mkdir -p ${OUT_DIR}
cd /ffmpeg/FFmpeg-release-${FFMPEG_VERSION}

echo "Configuring ffmpeg..."
./configure --target-os=linux \
	--cross-prefix=${ANDROID_TC}/bin/arm-linux-androideabi- \
	--arch=arm \
	--cpu=cortex-a8 \
	--enable-runtime-cpudetect \
	--sysroot=${ANDROID_TC}/sysroot \
	--prefix=${OUT_DIR} \
	--pkg-config=${PKG_CONFIG} \
	--pkg-config-flags="--static" \
	--extra-ldflags='-pie -fpic -marm -fPIE' \
	--extra-cflags='-fpic -marm -fPIE -pie' \
	--enable-static

echo "Building ffmpeg..."
make -j

echo "Installing ffmpeg..."
make install

echo "Creating output archive..."
cd /out
tar cvfz ffmpeg-${FFMPEG_VERSION}-arm.tar.gz ffmpeg-${FFMPEG_VERSION}-arm

echo "Done!"
