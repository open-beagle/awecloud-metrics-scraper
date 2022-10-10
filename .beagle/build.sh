#!/bin/bash

set -ex

mkdir -p $PWD/dist

# apt-get update
# apt-get install -y ca-certificates git gcc libc-dev libncurses5-dev sqlite3

echo "Build script building for amd64";

go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o $PWD/dist/metrics-sidecar-linux-amd64 \
$PWD

echo "Detected ARM64. Setting additional variables.";

env CC=aarch64-linux-gnu-gcc \
CGO_ENABLED=1 \
GOOS=linux \
GOARCH=arm64 \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o $PWD/dist/metrics-sidecar-linux-arm64 \
$PWD

echo "Detected ppc64le. Setting additional variables.";

env CC=powerpc64le-linux-gnu-gcc \
CGO_ENABLED=1 \
GOOS=linux \
GOARCH=ppc64le \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o $PWD/dist/metrics-sidecar-linux-ppc64le \
$PWD

echo "Detected mips64le. Setting additional variables.";

env CC=mips64el-linux-gnuabi64-gcc \
CGO_ENABLED=1 \
GOOS=linux \
GOARCH=mips64le \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o $PWD/dist/metrics-sidecar-linux-mips64le \
$PWD