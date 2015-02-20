FROM debian:wheezy
MAINTAINER Clayton Auzenne <cauzenne@mujijn.co.jp>

##################

# Debian packages
##################

RUN \
 apt-get update; \
apt-get -y --force-yes --no-install-recommends install liblapack-dev libjpeg8-dev libogg-dev libpng12-dev libqhull-dev libqrupdate1 libqt4-scripttools libsimage-dev  qt4-dev-tools libhdf5-serial-dev python-h5py libpcre++-dev python-matplotlib libsoqt4-dev python-empy libxml2-dev; \
apt-get -y --force-yes --no-install-recommends install libboost-dev libboost-python-dev libboost-filesystem-dev libboost-iostreams-dev libboost-math-dev libboost-program-options-dev libboost-regex-dev libboost-random-dev libboost-serialization-dev libboost-signals-dev libboost-thread-dev libboost-wave-dev; \
apt-get -y --force-yes --no-install-recommends install git-core sudo;  \
apt-get -y --force-yes --no-install-recommends install cmake make wget bzip2 file; \
apt-get -y --force-yes --no-install-recommends install module-init-tools tree vim libassimp-dev less build-essential; \
apt-get install -y module-init-tools mesa-utils libode-dev && \
apt-get autoclean -y && \
rm -rf /var/lib/apt/lists/*; \
usermod -s /bin/bash www-data;  \
usermod -m -d /data www-data;  \
gpasswd -a www-data sudo;  \
echo "www-data ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/www-data;  \
mkdir -p /data;  \
chown -R www-data:www-data /data; \
echo "deb http://ftp.jaist.ac.jp/debian/ wheezy main\ndeb-src http://ftp.jaist.ac.jp/debian/ wheezy main\ndeb http://security.debian.org/ wheezy/updates main\ndeb-src http://security.debian.org/ wheezy/updates main\ndeb http://ftp.jaist.ac.jp/debian/ wheezy-updates main\ndeb-src http://ftp.jaist.ac.jp/debian/ wheezy-updates main\ndeb ftp://ftp.jaist.ac.jp/pub/Linux/debian/ wheezy-backports main non-free contrib\ndeb-src ftp://ftp.jaist.ac.jp/pub/Linux/debian/ wheezy-backports main non-free contrib\ndeb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list; 

#RUN \
    #wget http://us.download.nvidia.com/XFree86/Linux-x86_64/346.35/NVIDIA-Linux-x86_64-346.35.run -O /tmp/nvidia.run && \
    #sh /tmp/nvidia.run -s --no-kernel-module && \
    #rm -f /tmp/nvidia.run

#RUN \
#    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add - && \
#    apt-get update

WORKDIR /data
ENV HOME /data
ENV SOURCE_DIR /data/src
ENV BUILD_DIR /data/build
ENV INSTALL_DIR /data/install
ENV COLLADA_DOM_SOURCE_DIR ${SOURCE_DIR}/collada-dom
ENV COLLADA_DOM_BUILD_DIR ${BUILD_DIR}/collada-dom
ENV LIBCCD_SOURCE_DIR $SOURCE_DIR/libccd
ENV LIBCCD_BUILD_DIR $BUILD_DIR/libccd


##########
# Run-time
##########
RUN \
mkdir -p $SOURCE_DIR; \
mkdir -p $BUILD_DIR; \
sudo apt-get update; \
sudo apt-get -y --force-yes --no-install-recommends install ipython python-scipy python-pip; \
sudo pip install nose coverage; \
apt-get -y --force-yes --no-install-recommends install tree vim libassimp-dev less build-essential ca-certificates python-pip; \
git config --global http.sslVerify false; \
git clone https://github.com/rdiankov/collada-dom.git $COLLADA_DOM_SOURCE_DIR; \
  mkdir -p $COLLADA_DOM_BUILD_DIR; \
  cd $COLLADA_DOM_BUILD_DIR && cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DOPT_DOUBLE_PRECISION=ON $COLLADA_DOM_SOURCE_DIR; \
  cd $COLLADA_DOM_BUILD_DIR && make -j4; \
  cd $COLLADA_DOM_BUILD_DIR && make install;\
git clone https://github.com/danfis/libccd.git $LIBCCD_SOURCE_DIR; \
  mkdir -p $LIBCCD_BUILD_DIR; \
  cd $LIBCCD_BUILD_DIR && cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $LIBCCD_SOURCE_DIR; \
  cd $LIBCCD_BUILD_DIR && make -j4; \
  cd $LIBCCD_BUILD_DIR && make install
  
USER www-data

VOLUME ${INSTALL_DIR}
