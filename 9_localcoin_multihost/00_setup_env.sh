#!/bin/bash

export PROJECT_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

. $PROJECT_ROOT/../utils.sh
. $PROJECT_ROOT/../version.sh

checkToolVersion
export LOCAL_ROOT_PATH=$PWD
export CA_ORDERER_LOCALCOIN="ca.orderer.localcoin.jp:7054"
export CA_SDL_LOCALCOIN="ca.sdl.localcoin.jp:8054"
export CA_TLS_LOCALCOIN="tlsca.localcoin.jp:6054"
export FABRIC_CFG_PATH=$PROJECT_ROOT/config