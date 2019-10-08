#! /bin/bash

INSTALL_DIR=/opt/intel/openvino
TEMP_DIR=/tmp/openvino_installer
DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15944/l_openvino_toolkit_p_2019.3.334.tgz

# Install dependencies
apt-get update

apt-get install -y --no-install-recommends cpio lsb-release sudo wget
apt-get install -y --no-install-recommends python3-pip python3 libpython3.6 libpython3.6-dev

update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

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
