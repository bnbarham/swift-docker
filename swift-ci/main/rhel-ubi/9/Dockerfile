FROM redhat/ubi9

RUN groupadd -g 42 build-user && \
    useradd -m -r -u 42 -g build-user build-user

RUN yum install -y  \
  git               \
  gcc-c++           \
  cmake             \
  diffutils         \
  make              \
  libcurl-devel     \
  libedit-devel     \
  libuuid-devel     \
  libxml2-devel     \
  ncurses-devel     \
  python3-devel     \
  python3-pip       \
  rsync             \
  sqlite-devel      \
  unzip             \
  zip

COPY swift-ci/dependencies/requirements.txt /dependencies/
RUN pip3 install -r /dependencies/requirements.txt

COPY swift-ci/main/install-swift.sh /opt/swift/install.sh
RUN /opt/swift/install.sh ubi9 "$(rpm --eval '%{_arch}')"

USER build-user

WORKDIR /home/build-user
