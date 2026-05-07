DOCKER_FILE     ?= Dockerfile.home
IMAGE_NAME      ?= dockergenesis:latest
CONTAINER_NAME  ?= env_genesis

# Path to this project inside the container (see run.sh volume mounts)
CONTAINER_PROJECT_DIR = /root/code/config_genesis_in_docker

.PHONY: docker build run install

# Build the image, start the container (detached), install libs, then attach.
docker: build run-detached install
	@echo ""
	@echo "Libs installed. Attach to the container with:"
	@echo "  docker attach $(CONTAINER_NAME)"

# Build the Docker image using docker/build.sh.
# Set DOCKER_FILE=<path> to override the default (Dockerfile.home).
build:
	@if [ "$(DOCKER_FILE)" = "Dockerfile.home" ]; then \
		echo "WARNING: Building with default Dockerfile 'docker/Dockerfile.home'."; \
		echo "         Set DOCKER_FILE=<path> to use a different Dockerfile."; \
	fi
	@cd docker && DOCKER_FILE=$(DOCKER_FILE) bash build.sh

# Start the container interactively via docker/run.sh.
run:
	@cd docker && bash run.sh

# Start the container in detached mode with the same settings as run.sh.
run-detached:
	@xhost +local:docker 2>/dev/null || true
	@if docker ps -q -f name=^/$(CONTAINER_NAME)$$ | grep -q .; then \
		echo "Container '$(CONTAINER_NAME)' is already running."; \
	else \
		docker run -d \
		    --cap-add=SYS_PTRACE \
		    --security-opt seccomp=unconfined \
		    --security-opt apparmor=unconfined \
		    --shm-size=16g \
		    --ulimit memlock=-1 \
		    --env="DISPLAY=$$DISPLAY" \
		    --env="QT_X11_NO_MITSHM=1" \
		    --gpus all \
		    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display \
		    -v /usr/local/cuda-12.8:/usr/local/cuda \
		    -v /usr/share/nvidia/nvoptix.bin:/usr/share/nvidia/nvoptix.bin:ro \
		    -e PATH=/usr/local/cuda/bin:$$PATH \
		    -e LD_LIBRARY_PATH=/usr/local/cuda/lib64:$$LD_LIBRARY_PATH \
		    --ipc=host \
		    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		    --volume="$(shell pwd)/../..:/root/code:rw" \
		    --volume="/mydata:/root/data:rw" \
		    --volume="/dev/shm:/dev/shm:rw" \
		    --name=$(CONTAINER_NAME) \
		    $(IMAGE_NAME); \
	fi

# Run the install scripts inside the running container.
install:
	@echo "Installing cmake..."
	docker exec $(CONTAINER_NAME) bash -c "cd $(CONTAINER_PROJECT_DIR)/scripts && bash install_newcmake.sh"
	@echo "Installing Vulkan..."
	docker exec $(CONTAINER_NAME) bash -c "cd $(CONTAINER_PROJECT_DIR)/scripts && bash install_vulkan.sh"
	@echo "Installing NVIDIA OptiX..."
	docker exec $(CONTAINER_NAME) bash -c "cd $(CONTAINER_PROJECT_DIR)/scripts && bash install_nvidiaoptix.sh"
