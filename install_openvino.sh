#! /bin/bash

INSTALL_DIR=/opt/intel/openvino
TEMP_DIR=/tmp/openvino_installer
DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15944/l_openvino_toolkit_p_2019.3.334.tgz

# Install dependencies
apt-get update
apt-get upgrade -y

apt-get install -y cpio lsb-release sudo wget
apt-get install -y libjpeg-dev libpng-dev libtiff-dev
apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get install -y libxvidcore-dev libx264-dev libomp-dev
apt-get install -y libatlas-base-dev gfortran
apt-get install -y build-essential cmake pkg-config
apt-get install -y libsm6 libxext6

apt-get install -y curl python3.7 python3.7-dev python3.7-distutils

update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
update-alternatives --set python /usr/bin/python3.7

curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py --force-reinstall && \
    rm get-pip.py

pip install numpy

# Get OpenVINO
mkdir -p $TEMP_DIR
cd $TEMP_DIR
wget -c $DOWNLOAD_LINK

# Install OpenVINO
tar -xzf l_openvino_toolkit*.tgz
rm l_openvino_toolkit*.tgz

cd l_openvino_toolkit*
sed -i 's/decline/accept/g' silent.cfg
./install.sh -s silent.cfg --cli-mode

cd /opt
rm -rf $TEMP_DIR
$INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh

# Clean up disk
rm -rf /opt/intel/openvino_2019.3.33/openvino_toolkit_uninstaller
rm -rf /opt/intel/openvino_2019.3.33/install_dependencies
rm -rf /opt/intel/openvino_2019.3.33/documentation
rm -rf /opt/intel/openvino_2019.3.33/licensing

rm -rf /opt/intel/openvino_2019.3.334/deployment_tools/open_model_zoo
rm -rf /opt/intel/openvino_2019.3.334/deployment_tools/tools
rm -rf /opt/intel/openvino_2019.3.334/deployment_tools/intel_models
rm -rf /opt/intel/openvino_2019.3.334/deployment_tools/demo
rm -rf /opt/intel/openvino_2019.3.334/deployment_tools/model_optimizer

rm -rf /opt/intel/openvino_2019.3.334/openvx/samples

rm -rf /opt/intel/mediasdk

apt-get autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*
