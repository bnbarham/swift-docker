FROM debian:12

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 998 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get -y update && apt-get -y install \
  build-essential       \
  clang                 \
  cmake                 \
  diffutils             \
  git                   \
  icu-devtools          \
  libcurl4-openssl-dev  \
  libedit-dev           \
  libicu-dev            \
  libncurses-dev        \
  libpython3-dev        \
  libsqlite3-dev        \
  libxml2-dev           \
  ninja-build           \
  pkg-config            \
  python3-distutils     \
  python3-pip           \
  python3-pkg-resources \
  python3-psutil        \
  rsync                 \
  swig                  \
  systemtap-sdt-dev     \
  tzdata                \
  uuid-dev              \
  zip                   \
  libstdc++-12-dev

COPY swift-ci/dependencies/requirements.txt /dependencies/
RUN pip3 install -r /dependencies/requirements.txt --break-system-packages

COPY swift-ci/main/install-swift.sh /opt/swift/install.sh
RUN apt-get -q update && apt-get -q install -y curl && rm -rf /var/lib/apt/lists/* \
    && /opt/swift/install.sh debian12 "$(dpkg --print-architecture)" \
    && apt-get purge --auto-remove -y curl

USER build-user

WORKDIR /home/build-user
