FROM debian:wheezy
MAINTAINER Clayton Auzenne <cauzenne@mujijn.co.jp>

##################
# Debian packages
##################

RUN apt-get update -y

# openrave dependency
RUN apt-get -y --force-yes --no-install-recommends install liblapack-dev libjpeg8-dev libogg-dev libpng12-dev libqhull-dev libqrupdate1 libqt4-scripttools libsimage-dev  qt4-dev-tools libhdf5-serial-dev python-h5py libpcre++-dev python-matplotlib libsoqt4-dev python-empy libxml2-dev

# boost
RUN apt-get -y --force-yes --no-install-recommends install libboost-dev libboost-python-dev libboost-filesystem-dev libboost-iostreams-dev libboost-math-dev libboost-program-options-dev libboost-regex-dev libboost-random-dev libboost-serialization-dev libboost-signals-dev libboost-thread-dev libboost-wave-dev

# git
RUN apt-get -y --force-yes --no-install-recommends install git-core sudo
RUn git config --global http.sslVerify false

# build
RUN apt-get -y --force-yes --no-install-recommends install cmake make wget bzip2 file

# insmod
RUN apt-get -y --force-yes --no-install-recommends install module-init-tools tree vim libassimp-dev less build-essential 

RUN \
   apt-get install -y module-init-tools mesa-utils libode-dev && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*

#RUN \
    #wget http://us.download.nvidia.com/XFree86/Linux-x86_64/346.35/NVIDIA-Linux-x86_64-346.35.run -O /tmp/nvidia.run && \
    #sh /tmp/nvidia.run -s --no-kernel-module && \
    #rm -f /tmp/nvidia.run

RUN \
    usermod -s /bin/bash www-data && \
    usermod -m -d /data www-data && \
    gpasswd -a www-data sudo && \
    echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/www-data && \
    mkdir -p /data && \
    chown -R www-data:www-data /data
RUN \
    echo "deb http://ftp.jaist.ac.jp/debian/ wheezy main\ndeb-src http://ftp.jaist.ac.jp/debian/ wheezy main\ndeb http://security.debian.org/ wheezy/updates main\ndeb-src http://security.debian.org/ wheezy/updates main\ndeb http://ftp.jaist.ac.jp/debian/ wheezy-updates main\ndeb-src http://ftp.jaist.ac.jp/debian/ wheezy-updates main\ndeb ftp://ftp.jaist.ac.jp/pub/Linux/debian/ wheezy-backports main non-free contrib\ndeb-src ftp://ftp.jaist.ac.jp/pub/Linux/debian/ wheezy-backports main non-free contrib\ndeb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list

#RUN \
#    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add - && \
#    apt-get update

WORKDIR /data
ENV HOME /data
USER www-data

#####################
# Build from sources
#####################
ENV SOURCE_DIR /data/src
ENV BUILD_DIR /data/build
RUN mkdir -p $SOURCE_DIR
RUN mkdir -p $BUILD_DIR

# collada-dom
#ENV COLLADA_DOM_SOURCE_DIR $SOURCE_DIR/collada-dom
#ENV COLLADA_DOM_BUILD_DIR $BUILD_DIR/collada-dom
#RUN git clone https://github.com/rdiankov/collada-dom.git $COLLADA_DOM_SOURCE_DIR
#RUN cd $COLLADA_DOM_SOURCE_DIR && git checkout b67e4e68d302d28454265ee7bd58cc692333a625
#RUN mkdir -p $COLLADA_DOM_BUILD_DIR
#RUN cd $COLLADA_DOM_BUILD_DIR && cmake -DCMAKE_BUILD_TYPE=Release -DOPT_DOUBLE_PRECISION=ON $COLLADA_DOM_SOURCE_DIR
#RUN cd $COLLADA_DOM_BUILD_DIR && make -j4
#RUN cd $COLLADA_DOM_BUILD_DIR && make install

# libccd
#ENV LIBCCD_SOURCE_DIR $SOURCE_DIR/libccd
#ENV LIBCCD_BUILD_DIR $BUILD_DIR/libccd
#RUN git clone https://github.com/danfis/libccd.git $LIBCCD_SOURCE_DIR
#RUN cd $LIBCCD_SOURCE_DIR && git checkout 2ddebf8917da5812306f74520d871ac8d8c1871e
#RUN mkdir -p $LIBCCD_BUILD_DIR
#RUN cd $LIBCCD_BUILD_DIR && cmake -DCMAKE_BUILD_TYPE=Release $LIBCCD_SOURCE_DIR
#RUN cd $LIBCCD_BUILD_DIR && make -j4
#RUN cd $LIBCCD_BUILD_DIR && make install

# openrave
#ENV OPENRAVE_SOURCE_DIR $SOURCE_DIR/openrave
#ENV OPENRAVE_BUILD_DIR $BUILD_DIR/openrave
#RUN git clone https://github.com/rdiankov/openrave.git $OPENRAVE_SOURCE_DIR
#RUN cd $OPENRAVE_SOURCE_DIR && git fetch origin && git checkout 15e5c7c63f2f45603d2ab647027310f508d66b70
#RUN mkdir -p $OPENRAVE_BUILD_DIR
#RUN cd $OPENRAVE_BUILD_DIR && cmake -DCMAKE_BUILD_TYPE=Release -DODE_USE_MULTITHREAD=ON -DOPT_IKFAST_FLOAT32=OFF $OPENRAVE_SOURCE_DIR
#RUN cd $OPENRAVE_BUILD_DIR && make -j4
#RUN cd $OPENRAVE_BUILD_DIR && make install -j4

##########
# Run-time
##########
#RUN apt-get -y --force-yes --no-install-recommends install ipython python-scipy

