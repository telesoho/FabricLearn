#!/bin/bash
. ../../../utils.sh
. ../../../version.sh

checkToolVersion
export LOCAL_ROOT_PATH=$PWD
export CA_ORDERER_LOCALCOIN="ca.orderer.localcoin.jp:7054"
export CA_SDL_LOCALCOIN="ca.sdl.localcoin.jp:8054"
export CA_TLS_LOCALCOIN="tlsca.localcoin.jp:6054"

