FROM localhost:5000/openrave-wheezy-cinvoke
MAINTAINER Clayton Auzenne <cauzenne@mujijn.co.jp>

ENV SOURCE_DIR /data/src
ENV BUILD_DIR /data/build
ENV INSTALL_DIR /data/install

ENV OPENRAVE_SOURCE_DIR $SOURCE_DIR/openrave
ENV OPENRAVE_BUILD_DIR $BUILD_DIR/openrave
RUN \ 
  mkdir -p $SOURCE_DIR && \
  mkdir -p $BUILD_DIR && \
  mkdir -p $INSTALL_DIR

#ADD /var/test/ /data/install
RUN git config --global http.sslVerify false 
RUN \
  git clone https://github.com/rdiankov/openrave.git $OPENRAVE_SOURCE_DIR && \
  cd $OPENRAVE_SOURCE_DIR && git fetch origin && git checkout latest_stable && \
RUN mkdir -p $OPENRAVE_BUILD_DIR
RUN cd $OPENRAVE_BUILD_DIR && cmake -DCMAKE_BUILD_TYPE=Release -DODE_USE_MULTITHREAD=ON -DOPT_IKFAST_FLOAT32=OFF $OPENRAVE_SOURCE_DIR
RUN cd $OPENRAVE_BUILD_DIR && make -j4
RUN cd $OPENRAVE_BUILD_DIR && make install -j4
VOLUME ${INSTALL_DIR}
