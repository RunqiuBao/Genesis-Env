apt-get update && apt-get install -y \
    libvulkan-dev \
    libvulkan1 \
    glslang-tools \
    glslang-dev \
    spirv-tools \
    mesa-vulkan-drivers

mkdir -p /usr/share/glvnd/egl_vendor.d/ && echo '{"file_format_version":"1.0.0","ICD":{"library_path":"libEGL_nvidia.so.0"}}' > /usr/share/glvnd/egl_vendor.d/10_nvidia.json

echo 'export VULKAN_SDK=/usr' >> ~/.bashrc
echo 'export VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PYOPENGL_PLATFORM=egl' >> ~/.bashrc
echo 'export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json' >> ~/.bashrc

echo -e 'run this to enable: source ~/.bashrc'
