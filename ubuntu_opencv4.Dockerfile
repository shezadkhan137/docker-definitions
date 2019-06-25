FROM ubuntu:18.04

# NOTE: remove libomp-dev if you do not want to OpenMP
RUN apt-get update && apt-get upgrade -y && apt-get -y install \
    build-essential cmake pkg-config \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libomp-dev \
    libatlas-base-dev gfortran \
    python3-dev python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 && update-alternatives --set python /usr/bin/python3.6

WORKDIR /opt

COPY install_opencv4.sh /opt/install_opencv4.sh
RUN ./install_opencv4.sh && rm install_opencv4.sh
