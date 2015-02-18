FROM localhost:5000/openrave-wheezy-cinvoke
MAINTAINER Clayton Auzenne <cauzenne@mujijn.co.jp>

ENV  SOURCE_DIR /data/src
ENV BUILD_DIR /data/build
ENV INSTALL_DIR /data/install
ENV COLLADA_DOM_SOURCE_DIR ${SOURCE_DIR}/collada-dom
ENV COLLADA_DOM_BUILD_DIR ${BUILD_DIR}/collada-dom
RUN \
  mkdir -p $SOURCE_DIR && \
  mkdir -p $BUILD_DIR && \	
  mkdir -p $INSTALL_DIR 



RUN git config --global http.sslVerify false 
RUN \
  git clone https://github.com/rdiankov/collada-dom.git $COLLADA_DOM_SOURCE_DIR && \
  mkdir -p $COLLADA_DOM_BUILD_DIR && \
  cd $COLLADA_DOM_BUILD_DIR && cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DOPT_DOUBLE_PRECISION=ON $COLLADA_DOM_SOURCE_DIR && \
  cd $COLLADA_DOM_BUILD_DIR && make -j4  && \
  cd $COLLADA_DOM_BUILD_DIR && make install

VOLUME ${INSTALL_DIR}
