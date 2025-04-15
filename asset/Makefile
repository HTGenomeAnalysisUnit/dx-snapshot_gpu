SHELL=/bin/bash -e -x -o pipefail
all:
	sudo mv /etc/apt/apt.conf.d/99dnanexus /tmp/
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb
	sudo dpkg -i cuda-keyring_1.1-1_all.deb
	sudo apt-get update
	# example below specifies CUDA version 12.1.
	# nvidia provides forward compatibility packages for other CUDA versions as well
	sudo DEBIAN_FRONTEND=noninteractive apt-get -y install cuda-toolkit-12-1 cuda-compat-12-1
	sudo bash -c "echo /usr/local/cuda/compat > /etc/ld.so.conf.d/nvidia-compat.conf"
	sudo ldconfig
	sudo rm cuda-keyring_1.1-1_all.deb
	sudo mv /tmp/99dnanexus /etc/apt/apt.conf.d/99dnanexus