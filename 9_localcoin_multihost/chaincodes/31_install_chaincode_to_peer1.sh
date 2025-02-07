#!/bin/bash -eu
. env_peer1.sh

CHANNELS_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/channels
infoln "Join Peer 1 Node to the Channel"
peer channel join -b $CHANNELS_FOLDER/sdlchannel.block -o $ORDERER --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES --tls 2>&1 1>&log.txt
ifErrorPause

. install_chaincode.sh --name odoo-user --src $PROJECT_ROOT/chaincodes/src/odoo-user \
    --lang javascript --channel sdlchannel --nocommit TRUE

peer chaincode invoke -o $ORDERER --tls --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES --channelID sdlchannel \
    --name odoo-user -c '{"Args":["Test"]}'
ifErrorPause

noteln "All Done!"
