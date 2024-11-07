#!/bin/sh

ARCH=""

case $(uname -m) in
    x86_64)  ARCH="amd64";;
    armv6l)  ARCH="armv6l";;
    armv7l)  ARCH="armv6l";;
    aarch64) ARCH="arm64";;
    i686)    ARCH="386";;
    i386)    ARCH="386";;
esac

LOCAL_VERSION=$(go version)

REMOTE_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)

TMP_LOCATION="/tmp/go.tar.gz"

if [[ "$LOCAL_VERSION" == *"$REMOTE_VERSION"* ]]; then

    echo "Already up to date."

else

    wget https://go.dev/dl/${REMOTE_VERSION}.linux-${ARCH}.tar.gz -O ${TMP_LOCATION}

    # Use sudo to get permission to remove old version and install new version
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${TMP_LOCATION}

    rm ${TMP_LOCATION}

fi
