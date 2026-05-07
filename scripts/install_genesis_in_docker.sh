readonly RED='\033[1;31m'
readonly GREEN='\033[0;32m'
readonly RESET_COLOR='\e[0m'

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/nccl/lib:$LD_LIBRARY_PATH

# install genesis
(cd /root/code/
git clone https://github.com/Genesis-Embodied-AI/Genesis.git
cd Genesis/
pip install --upgrade pip setuptools wheel
pip install -e ".[dev]"
)
echo -e "${GREEN}finished installing genesis.${RESET_COLOR}"

# install render
(cd /root/code/Genesis/
git submodule update --init --recursive
cd /root/code/config_genesis_in_docker/scripts/
bash install_luisarender.sh
)
echo -e "${GREEN}finished installing luisa-render.${RESET_COLOR}"
