FROM ubuntu

# for TZ data
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update --fix-missing
RUN apt-get install -y git

# Recommended installation options for ubuntu 18.04
RUN apt install -y pkg-config git cmake build-essential nasm wget python3-setuptools libusb-1.0-0-dev  python3-dev python3-pip python3-numpy python3-scipy libglew-dev libglfw3-dev libtbb-dev
RUN apt install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev ffmpeg x264 x265 libportaudio2 portaudio19-dev
RUN apt install -y python3-opencv libopencv-dev
RUN apt install -y libgoogle-glog-dev libatlas-base-dev libeigen3-dev
RUN apt install -y libceres-dev


RUN mkdir -p /home/user
WORKDIR /home/user

# install Turbojet
RUN wget -O libjpeg-turbo.tar.gz https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-1.5.1.tar.gz/download && \
    tar xvzf libjpeg-turbo.tar.gz && \
    cd libjpeg-turbo-1.5.1 && \
    ./configure --enable-static=no --prefix=/usr/local && \
    make install -j4 && \
    ldconfig

#RUN apt-get install -y libuvc-dev

RUN git clone https://github.com/pupil-labs/libuvc && \
    cd libuvc && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j4 && make install

# enable libuvc as normal user
#RUN echo 'SUBSYSTEM=="usb",  ENV{DEVTYPE}=="usb_device", GROUP="plugdev", MODE="0664"' | tee /etc/udev/rules.d/10-libuvc.rules > /dev/null && \
#    udevadm trigger

RUN apt-get install -y python3-venv

SHELL ["/bin/bash", "-c"]

RUN cd /home/user
RUN python3 -m venv venv
#RUN source venv/bin/activate && pip install cysignals

#install python libraries
RUN pip3 -v install cysignals
RUN pip3 install cython
RUN pip3 install msgpack==0.5.6
RUN pip3 install numexpr
RUN pip3 install packaging
RUN pip3 install psutil
RUN pip3 install pyaudio
RUN pip3 install pyopengl
RUN pip3 install pyzmq
RUN pip3 install scipy
RUN pip3 install git+https://github.com/zeromq/pyre
RUN pip3 install scikit-build
RUN pip3 install git+https://github.com/pupil-labs/PyAV
RUN pip3 install git+https://github.com/pupil-labs/pyuvc
RUN pip3 install git+https://github.com/pupil-labs/pyndsi
RUN pip3 install git+https://github.com/pupil-labs/pyglui
RUN pip3 install git+https://github.com/pupil-labs/nslr
RUN pip3 install git+https://github.com/pupil-labs/nslr-hmm

#RUN pip3 install pupil_apriltags
#RUN pip3 install torch torchvision
