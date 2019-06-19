FROM ubuntu:16.04

RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        unzip \
        vim \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG UNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $UNAME && \
    useradd -m -u $UID -g $GID -s /bin/bash $UNAME

RUN mkdir /ndk /ffmpeg /out

VOLUME ["/out"]

COPY build-ffmpeg.sh ffmpeg-pkg-config /ffmpeg/

ADD https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip /ndk/
WORKDIR /ndk
RUN unzip android-ndk-r10e-linux-x86_64.zip
RUN ./android-ndk-r10e/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.8 --platform=android-14 --install-dir=toolchain-android-r10e --system=linux-x86_64

ADD https://github.com/FFmpeg/FFmpeg/archive/release/4.0.zip /ffmpeg/
WORKDIR /ffmpeg
RUN unzip 4.0.zip
RUN chown -R $UNAME.$UNAME /ndk /ffmpeg /out

USER $UNAME


CMD ["/ffmpeg/build-ffmpeg.sh"]
