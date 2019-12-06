YARA_VERSION=3.11.0
YEXTEND_VERSION=1.6
UPX_VERSION=3.95

# ---- Install YARA
wget https://github.com/VirusTotal/yara/archive/v${YARA_VERSION}.tar.gz
tar -xzf v${YARA_VERSION}.tar.gz
cd /opt/yara-${YARA_VERSION}
./bootstrap.sh
./configure
make
make install
cd /opt
rm -rf /opt/yara-${YARA_VERSION}
rm v${YARA_VERSION}.tar.gz

# ---- yextend dependencies
apt-get update && apt-get install -y \
    poppler-utils libarchive-dev libssl-dev \
    zlib1g-dev libbz2-dev libpcre3-dev uuid-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Install yextend - note that some manual tweaking of files is required
wget https://github.com/BayshoreNetworks/yextend/archive/${YEXTEND_VERSION}.tar.gz
tar -xzf ${YEXTEND_VERSION}.tar.gz
cd /opt/yextend-${YEXTEND_VERSION}

# We need to replace the yara version (line 473 on main.cpp) because the way that the
# yara version check works is broken.  To get around this, we just hardcode the yara
# version to something that passes the version check.
sed -i 's/double yara_version = get_yara_version()/double yara_version = 3.8/' main.cpp

# In libs/bayshore_yara_wrapper.c they reference TRUE and FALSE which are not defined in C.
# To fix this, we define TRUE and FALSE in libs/bayshore_yara_wrapper.h.
sed -i 's/#define YEXTEND_VERSION 1.6/#define YEXTEND_VERSION 1.6\n\n#define TRUE 1\n#define FALSE 0/' libs/bayshore_yara_wrapper.h

# required for the yextend unittests to pass
pip install nose~=1.3.7

# build yextend
./build.sh
mv yextend /usr/local/bin
cd /opt
rm ${YEXTEND_VERSION}.tar.gz
rm -rf yextend-${YEXTEND_VERSION}

# ---- Install UPX
wget https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz
tar -xf upx-${UPX_VERSION}-amd64_linux.tar.xz
mv upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin/upx
rm upx-${UPX_VERSION}-amd64_linux.tar.xz
rm -rf upx-${UPX_VERSION}-amd64_linux
