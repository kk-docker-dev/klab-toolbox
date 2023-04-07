# Klab's collection of Linux applications

# Pull the image
	docker pull kribakarans/toolbox

# Run container
	docker run \
	       --detach \
	       -h toolbox \
	       -e DISPLAY=:0 \
	       --name klab-toolbox \
	       -v $HOME:/data \
	       -v /tmp/.X11-unix:/tmp/.X11-unix \
	       kribakarans/toolbox

# Run toolbox application from host
	docker exec -it klab-toolbox menu
	docker exec -it klab-toolbox bash
	docker exec -it klab-toolbox firefox

### Manage Docker image
**Build and push AMD64 image**

	sudo docker build -t kribakarans/toolbox:amd64 .
	sudo docker push kribakarans/toolbox:amd64

**Build and push ARM64 image**

	sudo docker build -t kribakarans/toolbox:arm64 .
	sudo docker push kribakarans/toolbox:arm64

**Create and push manifest**

	sudo docker manifest rm kribakarans/toolbox:latest
	sudo docker manifest create kribakarans/toolbox:latest kribakarans/toolbox:amd64 kribakarans/toolbox:arm64
	sudo docker manifest push kribakarans/toolbox:latest
