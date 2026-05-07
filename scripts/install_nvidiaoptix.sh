chmod +x NVIDIA-OptiX-SDK-9.0.0-linux64-x86_64.sh
mkdir -p /opt/optix
./NVIDIA-OptiX-SDK-9.0.0-linux64-x86_64.sh --skip-license --prefix=/opt/optix
echo 'export OptiX_INSTALL_DIR=/opt/optix' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/optix/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo -e "run this to enable: source ~/.bashrc"
echo -e "verify installation by: ls /opt/optix/include/optix.h"
