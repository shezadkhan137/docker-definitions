#! /usr/bin/env bash

apt-get update && apt-get install -y wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

wget -O opencv-4.1.0.zip https://github.com/opencv/opencv/archive/4.1.0.zip
wget -O opencv-contrib-4.1.0.zip https://github.com/opencv/opencv_contrib/archive/4.1.0.zip
unzip opencv-4.1.0.zip
unzip opencv-contrib-4.1.0.zip
mv opencv-4.1.0 opencv
mv opencv_contrib-4.1.0 opencv_contrib

pip3 install numpy

mkdir -p opencv/build

cd /opt/opencv/build

# NOTE: remove WITH_OPENMP option if you do not want to compile with OpenMP
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D INSTALL_C_EXAMPLES=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
	-D PYTHON_EXECUTABLE=python3 \
	-D WITH_OPENMP=ON \
	-D BUILD_EXAMPLES=OFF ..

make -j6
make install
ldconfig

rm /opt/opencv-4.1.0.zip
rm /opt/opencv-contrib-4.1.0.zip
rm -rf /opt/opencv
rm -rf /opt/opencv_contrib

apt-get remove -y wget unzip
