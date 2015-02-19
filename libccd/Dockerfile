FROM localhost:5000/openrave-wheezy-cinvoke
MAINTAINER Clayton Auzenne <cauzenne@mujijn.co.jp>

WORKDIR /data
ENV HOME /data
USER www-data

#####################
# Build from sources
#####################
ENV SOURCE_DIR /data/src
ENV BUILD_DIR /data/build
ENV INSTALL_DIR /data/install

RUN \
  mkdir -p $SOURCE_DIR && \
  mkdir -p $BUILD_DIR && \
  mkdir -p $INSTALL_DIR && \
  git config --global http.sslVerify false

# libccd
ENV LIBCCD_SOURCE_DIR $SOURCE_DIR/libccd
ENV LIBCCD_BUILD_DIR $BUILD_DIR/libccd
RUN \
  git clone https://github.com/danfis/libccd.git $LIBCCD_SOURCE_DIR && \
  mkdir -p $LIBCCD_BUILD_DIR && \
  cd $LIBCCD_BUILD_DIR && cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $LIBCCD_SOURCE_DIR && \
  cd $LIBCCD_BUILD_DIR && make -j4 && \
  cd $LIBCCD_BUILD_DIR && make install


VOLUME ${INSTALL_DIR}
