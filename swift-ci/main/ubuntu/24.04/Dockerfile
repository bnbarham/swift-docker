FROM ubuntu:24.04

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 998 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get -y update && apt-get -y install \
  build-essential       \
  cmake                 \
  git                   \
  icu-devtools          \
  libc++-18-dev         \
  libc++abi-18-dev      \
  libcurl4-openssl-dev  \
  libedit-dev           \
  libicu-dev            \
  libncurses5-dev       \
  libpython3-dev        \
  libsqlite3-dev        \
  libxml2-dev           \
  ninja-build           \
  pkg-config            \
  python3-six           \
  python3-pip           \
  python3-pkg-resources \
  python3-psutil        \
  python3-setuptools    \
  rsync                 \
  swig                  \
  systemtap-sdt-dev     \
  tzdata                \
  uuid-dev              \
  zip

COPY swift-ci/dependencies/requirements.txt /dependencies/
RUN pip3 install -r /dependencies/requirements.txt --break-system-packages

COPY swift-ci/main/install-swift.sh /opt/swift/install.sh
RUN apt-get -q update && apt-get -q install -y curl && rm -rf /var/lib/apt/lists/* \
    && /opt/swift/install.sh ubuntu24.04 "$(dpkg --print-architecture)" \
    && apt-get purge --auto-remove -y curl

USER build-user

WORKDIR /home/build-user
