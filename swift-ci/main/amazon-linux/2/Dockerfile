FROM amazonlinux:2

RUN yum install shadow-utils -y

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 42 -g build-user build-user

# The build needs a package from the EPEL repo so that needs to be enabled.
RUN amazon-linux-extras install epel -y

# Update and install needed build packages
RUN yum -y group install "development tools"
RUN yum -y install \
  cmake            \
  curl-devel       \
  gcc-c++          \
  git              \
  glibc-static     \
  libbsd-devel     \
  libedit-devel    \
  libicu-devel     \
  libuuid-devel    \
  libxml2-devel    \
  ncurses-devel    \
  pexpect          \
  pkgconfig        \
  procps-ng        \
  python           \
  python-devel     \
  python-pkgconfig \
  python-six       \
  python3-pip      \
  python3-devel    \
  python3-psutil   \
  rsync            \
  sqlite-devel     \
  swig             \
  tzdata           \
  unzip            \
  uuid-devel       \
  wget             \
  which            \
  zip

RUN mkdir -p /usr/local/lib/python3.7/site-packages/

COPY swift-ci/dependencies/requirements.txt /dependencies/
RUN pip3 install -r /dependencies/requirements.txt

RUN easy_install-3.7 six

COPY swift-ci/main/install-swift.sh /opt/swift/install.sh
RUN /opt/swift/install.sh amazonlinux2 "$(rpm --eval '${_arch}')" \

USER build-user

WORKDIR /home/build-user
