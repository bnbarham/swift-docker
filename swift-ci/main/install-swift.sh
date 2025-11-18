#!/bin/sh

set -e

if [ "$#" -ne 2 ]; then
   echo "Usage: $0 <PLATFORM> <ARCH_NAME>... $@"
   exit 1
fi

PLATFORM=$1
ARCH_NAME=$2
VERSION=6.0.3
BRANCH=swift-${VERSION}-release
TAG=swift-${VERSION}-RELEASE
WEBROOT=https://download.swift.org
PREFIX=/opt/swift/${VERSION}

case "${ARCH_NAME##*-}" in
    'x86_64'|'amd64')
        OS_ARCH_SUFFIX=''
        ;;
    'arm64'|'aarch64')
        OS_ARCH_SUFFIX='-aarch64'
        ;;
    *)
        echo "error: unsupported architecture: '$ARCH_NAME'"
        exit 1
        ;;
esac
WEBDIR="$WEBROOT/$BRANCH/$(echo $PLATFORM | tr -d .)$OS_ARCH_SUFFIX"
BIN_URL="$WEBDIR/$TAG/$TAG-$PLATFORM$OS_ARCH_SUFFIX.tar.gz"
SIG_URL="$BIN_URL.sig"

echo "Downloading toolchain tarball from '$BIN_URL'..."
curl -fsSL "$BIN_URL" -o swift.tar.gz "$SIG_URL" -o swift.tar.gz.sig

echo "Verifying tarball signature..."
export GNUPGHOME="$(mktemp -d)"
curl -fSsL --compressed https://swift.org/keys/all-keys.asc | gpg --import -
gpg --batch --verify swift.tar.gz.sig swift.tar.gz

echo "Extracting toolchain tarball to '$PREFIX'..."
mkdir -p $PREFIX
tar -xzf swift.tar.gz --directory $PREFIX --strip-components=1
chmod -R o+r $PREFIX/usr/lib/swift
echo PATH="/opt/swift/${VERSION}/usr/bin:\${PATH}" >> /etc/profile
echo PATH="/opt/swift/${VERSION}/usr/bin:\${PATH}" >> /home/build-user/.bashrc

echo "Cleaning up..."
rm -rf "$GNUPGHOME" swift.tar.gz.sig swift.tar.gz
