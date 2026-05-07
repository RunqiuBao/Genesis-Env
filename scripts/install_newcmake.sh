apt update && apt install wget
wget https://github.com/Kitware/CMake/releases/download/v3.28.0/cmake-3.28.0-linux-x86_64.sh
chmod +x cmake-3.28.0-linux-x86_64.sh
./cmake-3.28.0-linux-x86_64.sh --skip-license --prefix=/usr/local
cmake --version

echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
echo -e 'do this to enable new cmake: source ~/.bashrc'
