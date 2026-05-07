(
cd /root/code/Genesis/genesis/ext/LuisaRender/
apt update && apt-get install -y libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libxext-dev uuid-dev libglvnd0 libglvnd-dev libegl1 libegl-dev
cmake  -S . -B build
cmake --build build -j $(nproc)
)
