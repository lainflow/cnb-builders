#!/bin/bash

set -euo pipefail

# Set variables
STACK_NAME="ofnee-stack"
BASE_IMAGE="${STACK_NAME}-base"
STACK_VERSION="0.1.0"
RUN_IMAGE_NAME="${STACK_NAME}-run"
BUILD_IMAGE_NAME="${STACK_NAME}-build"
# HTTP_PROXY="http://host.docker.internal:7890"
# HTTPS_PROXY="http://host.docker.internal:7890"

# Build base image
echo "Building base image..."
docker build \
  -t ${BASE_IMAGE}:${STACK_VERSION} \
  -f Dockerfile.base \
  --build-arg BASE_IMAGE=${BASE_IMAGE} \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  --network host \
  .

# Build run image
echo "Building run image..."
docker build \
  -t ${RUN_IMAGE_NAME}:${STACK_VERSION} \
  -f Dockerfile.run \
  --build-arg BASE_IMAGE=${BASE_IMAGE}:${STACK_VERSION} \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  --network host \
  .

# Build build image
echo "Building build image..."
docker build \
  -t ${BUILD_IMAGE_NAME}:${STACK_VERSION} \
  -f Dockerfile.build \
  --build-arg BASE_IMAGE=${BASE_IMAGE}:${STACK_VERSION} \
  --build-arg HTTP_PROXY=${HTTP_PROXY:-} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY:-} \
  --network host \
  .

echo "Done."
