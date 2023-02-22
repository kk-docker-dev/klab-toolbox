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
