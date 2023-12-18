####################################################################################
###
### janusminer for HiveOS (Ubuntu 18.04)
###
### Created by dmp
###
####################################################################################

FROM ubuntu:18.04 AS build

RUN apt update && \
        apt install software-properties-common -y && \
        add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
        apt install build-essential python3.8 python3-pip opencl-headers pkg-config ocl-icd-opencl-dev gcc-11 g++-11 xxd -y && \
        rm -rf /var/cache/apt && \
        update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 90 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11 && \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 90 && \
        python3 -m pip install meson ninja
        
COPY . /code
COPY thirdparty/opencl/opencl.hpp /usr/include/CL/
RUN mkdir /build
WORKDIR /code
RUN --mount=type=cache,target=/build LDFLAGS='-lpthread -static-libgcc -static-libstdc++' meson /build/code --default-library static --buildtype=release
WORKDIR /build/code
RUN --mount=type=cache,target=/build meson configure -Denable-gpu-miner=true
RUN --mount=type=cache,target=/build ninja
RUN mkdir /install
RUN --mount=type=cache,target=/build DESTDIR=/install meson install

FROM scratch AS export-stage
COPY --from=build install/usr/local/bin/wart-miner .