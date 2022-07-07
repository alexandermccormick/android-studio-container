#!/usr/bin/env bash

DST_IMAGE=$1
BASE_IMAGE="android-studio-base"

if [ -z ${DST_IMAGE} ]; then echo "Destination image should be specified. Example: myrepo/android-studio:x" && exit; else echo "Destination image: $DST_IMAGE"; fi

# clean old containers
podman rm android_studio_container > /dev/null || echo ''

# Run Android-Studio with empty configurations
podman run -it --name=android_studio_container \
  --net=host \
  --env="DISPLAY" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v="$HOME/.Xauthority:/root/.Xauthority:rw" \
  $BASE_IMAGE \
  /android-studio/bin/studio.sh ; \
  podman commit android_studio_container $DST_IMAGE
