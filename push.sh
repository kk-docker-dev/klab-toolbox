#!/bin/bash

ARCH=$1

if [ -z $ARCH ]; then
	echo "ERROR: Architecture not specified !!!"
	echo "Try again with './push.sh amd64|arm64' options."
	exit 1
fi

set -x
docker tag kribakarans/toolbox:latest kribakarans/toolbox:$ARCH
sudo docker push kribakarans/toolbox:$ARCH
sudo docker manifest create --amend kribakarans/toolbox:latest kribakarans/toolbox:amd64 kribakarans/toolbox:arm64
sudo docker manifest push kribakarans/toolbox:latest
