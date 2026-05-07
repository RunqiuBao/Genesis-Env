# allow GUI application in docker container to reach host device.
# note GUI might still fail, try launching a few more times.
xhost +local:docker

docker run -it \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    --shm-size=16g \
    --ulimit memlock=-1 \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --gpus all \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display \
    -v /usr/local/cuda-12.8:/usr/local/cuda \
    -v /usr/share/nvidia/nvoptix.bin:/usr/share/nvidia/nvoptix.bin:ro \
    -e PATH=/usr/local/cuda/bin:${PATH} \
    -e LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH} \
    --ipc=host \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$(pwd)/../../:/root/code:rw" \
    --volume="/mydata:/root/data:rw" \
    --volume="/dev/shm:/dev/shm:rw" \
    --name=env_genesis \
    dockergenesis
echo "done"
