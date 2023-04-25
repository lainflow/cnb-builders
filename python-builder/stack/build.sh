#!/bin/bash

set -euo pipefail

# Set variables
BASE_IMAGE="ubuntu"
STACK_NAME="example-stack"
STACK_VERSION="0.1.0"
RUN_IMAGE_NAME="${STACK_NAME}-run"
BUILD_IMAGE_NAME="${STACK_NAME}-build"

# Build base image
echo "Building base image..."
docker build \
  -t ${STACK_NAME}-base:${STACK_VERSION} \
  -f base/Dockerfile \
  --build-arg BASE_IMAGE=${BASE_IMAGE} \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  .

# Build run image
echo "Building run image..."
docker build \
  -t ${RUN_IMAGE_NAME}:${STACK_VERSION} \
  -f run/Dockerfile \
  --build-arg BASE_IMAGE=${STACK_NAME}-base \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  .

# Build build image
echo "Building build image..."
docker build \
  -t ${BUILD_IMAGE_NAME}:${STACK_VERSION} \
  -f build/Dockerfile \
  --build-arg BASE_IMAGE=${STACK_NAME}-base \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  .

echo "Done."
