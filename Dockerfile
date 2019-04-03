FROM debian:stretch
MAINTAINER jordi.solsona@rakuten.com

# install system wide deps and target directories
RUN apt-get update && apt-get install -y \
      automake \
      autotools-dev \
      fuse \
      g++ \
      git \
      libcurl4-gnutls-dev \
      libfuse-dev \
      libssl-dev \
      libxml2-dev \
      make \
      pkg-config \
      && rm -rf /usr/share/doc/* \
      && rm -rf /usr/share/info/* \
      && rm -rf /tmp/* \
      && rm -rf /var/tmp/* \

# Prepare s3fs
COMMIT_HASH=99ec09f13a03003a4f4f60d21d15acd61b547b81
WORKDIR /usr/src/s3fs
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
      cd s3fs-fuse && \
      git checkout ${COMMIT_HASH} && \
      ./autogen.sh && \
      ./configure && \
      make -j"$(nproc)" && \
      make install && \
      rm -rf /usr/src/s3fs
