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
      && rm -rf /var/tmp/* 

# Prepare s3fs
ENV COMMIT_HASH=06032aa661f8cfd06b997147efb47f6e0f0bbb48
ENV COMMIT_PR_909=f2184e34ddcea6c5c9335160b88606d0233ae301

WORKDIR /usr/src/s3fs
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
    cd s3fs-fuse && \
    git config user.email "jordi.solsona@rakuten.com" && \
    git checkout ${COMMIT_HASH} && \
    git cherry-pick ${COMMIT_PR_909} && \
    ./autogen.sh && \
    ./configure && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /usr/src/s3fs
