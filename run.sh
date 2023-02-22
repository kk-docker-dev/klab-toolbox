#!/bin/bash

USER_HOME=/home/klab
CACHE_PATH=$HOME/.local/docker/toolbox/cache
CONFIG_PATH=$HOME/.local/docker/toolbox/config

mkdir -p $CACHE_PATH $CONFIG_PATH

docker run \
  --detach \
  -h toolbox \
  -e DISPLAY=:0 \
  --name klab-toolbox \
  -v $HOME:/data \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $CACHE_PATH:$USER_HOME/.cache \
  -v $CONFIG_PATH:$USER_HOME/.config \
  kribakarans/toolbox
