#!/bin/bash -eu
. env_peer1.sh

CHANNELS_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/channels
infoln "Join Peer 1 Node to the Channel"
peer channel join -b $CHANNELS_FOLDER/sdlchannel.block -o $ORDERER --cafile $ROOT_TLS_CA_CERTFILES --tls 2>&1 1>&log.txt; ifErrorPause

. install_chaincode.sh install-only

infoln "Invoke testing"
peer chaincode invoke -o $ORDERER --tls --cafile $ROOT_TLS_CA_CERTFILES --channelID sdlchannel \
    --name odoo-user -c '{"Args":["ClientAccountInfo"]}' 2>&1 1>&log.txt; ifErrorPause
cat log.txt

noteln "All Done!"