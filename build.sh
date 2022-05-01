#!/usr/bin/env bash

# Exit on error
set -o errexit

CONTAINER=$(buildah from docker://ubuntu:latest)
IMAGE_NAME="android-studio-base"
ANDROID_STUDIO_ARCHIVE=$1
ANDROID_STUDIO_INSTALL_PATH="/$ANDROID_STUDIO_ARCHIVE"

buildah config --label maintainer="Alexander McCormick <first name last name at proton mail dot com>" $CONTAINER

buildah run $CONTAINER dpkg --add-architecture i386
buildah run $CONTAINER apt update
buildah run $CONTAINER apt dist-upgrade -y

# Download specific Android Studio bundle (all packages).
buildah run $CONTAINER apt install -y curl unzip

buildah copy $CONTAINER $ANDROID_STUDIO_ARCHIVE $ANDROID_STUDIO_INSTALL_PATH

buildah run $CONTAINER tar -zxvf $ANDROID_STUDIO_INSTALL_PATH

buildah run $CONTAINER rm $ANDROID_STUDIO_INSTALL_PATH

# Install X11
buildah config --env DEBIAN_FRONTEND=noninteractive $CONTAINER
buildah run $CONTAINER apt install -y xorg


# Install other useful tools
buildah run $CONTAINER apt install -y neovim ant

# install Java
buildah run $CONTAINER apt install -y default-jdk

# Install prerequisites
buildah run $CONTAINER apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

# Clean up
buildah run $CONTAINER apt clean
buildah run $CONTAINER apt purge

buildah commit --format docker $CONTAINER $IMAGE_NAME
