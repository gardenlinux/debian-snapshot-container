#!/bin/bash

set -x

SNAPSHOT_IMAGE_ARM=$1
SNAPSHOT_IMAGE_AMD=$2
TARGET_VERSION=$3
IMAGE_NAME="gardenlinux/debian-snapshot-container"

export DOCKER_CLI_EXPERIMENTAL=enabled
CUSTOM_CRE="docker"
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin


$CUSTOM_CRE pull $SNAPSHOT_IMAGE_ARM
$CUSTOM_CRE pull $SNAPSHOT_IMAGE_AMD

$CUSTOM_CRE tag $SNAPSHOT_IMAGE_ARM ghcr.io/$IMAGE_NAME:arm64-$TARGET_VERSION
$CUSTOM_CRE tag $SNAPSHOT_IMAGE_AMD ghcr.io/$IMAGE_NAME:amd64-$TARGET_VERSION

$CUSTOM_CRE push ghcr.io/$IMAGE_NAME:arm64-$TARGET_VERSION 
$CUSTOM_CRE push ghcr.io/$IMAGE_NAME:amd64-$TARGET_VERSION

$CUSTOM_CRE manifest create ghcr.io/$IMAGE_NAME:$TARGET_VERSION ghcr.io/$IMAGE_NAME:arm64-$TARGET_VERSION ghcr.io/$IMAGE_NAME:amd64-$TARGET_VERSION

$CUSTOM_CRE manifest annotate ghcr.io/$IMAGE_NAME:$TARGET_VERSION ghcr.io/$IMAGE_NAME:arm64-$TARGET_VERSION --os linux --arch arm64
$CUSTOM_CRE manifest annotate ghcr.io/$IMAGE_NAME:$TARGET_VERSION ghcr.io/$IMAGE_NAME:amd64-$TARGET_VERSION --os linux --arch amd64


$CUSTOM_CRE manifest push ghcr.io/$IMAGE_NAME:$TARGET_VERSION
