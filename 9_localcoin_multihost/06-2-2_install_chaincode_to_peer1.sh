#!/bin/bash -eu
. env_peer1.sh

CHANNELS_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/channels
infoln "Join Peer 1 Node to the Channel"
peer channel join -b $CHANNELS_FOLDER/sdlchannel.block -o $ORDERER --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES --tls 2>&1 1>&log.txt
ifErrorPause

. install_chaincode.sh --name odoo-user --src $PROJECT_ROOT/chaincode/odoo-user \
    --lang javascript --channel sdlchannel --nocommit TRUE

noteln "All Done!"
