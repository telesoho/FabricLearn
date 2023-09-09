#!/bin/bash
source ../utils.sh
source ../version.sh
export LOCAL_ROOT_PATH=$PWD
export LOCAL_CA_PATH=$LOCAL_ROOT_PATH/orgs
export DOCKER_CA_PATH=/tmp
export COMPOSE_PROJECT_NAME=fabriclearn
export DOCKER_NETWORKS=network
export FABRIC_CFG_PATH=$LOCAL_ROOT_PATH/config