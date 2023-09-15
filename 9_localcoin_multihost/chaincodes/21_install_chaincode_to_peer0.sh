#!/bin/bash -eu
noteln "Install chaincode to peers"

infoln "install chaincode package to peer0"
. env_peer0.sh

. install_chaincode.sh --name odoo-user --src $PROJECT_ROOT/chaincodes/src/odoo-user \
    --lang javascript --channel sdlchannel

infoln "Invoke testing"
peer chaincode invoke -o $ORDERER --tls --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES --channelID sdlchannel \
    --name odoo-user -c '{"Args":["ClientAccountInfo"]}' 
