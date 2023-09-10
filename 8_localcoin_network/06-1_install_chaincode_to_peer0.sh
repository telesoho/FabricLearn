#!/bin/bash -eu
noteln "Install chaincode to peers"

infoln "install chaincode package to peer0"
. env_peer0.sh
. install_chaincode.sh

infoln "Invoke testing"
peer chaincode invoke -o $ORDERER --tls --cafile $ROOT_TLS_CA_CERTFILES --channelID sdlchannel \
    --name odoo-user -c '{"Args":["ClientAccountInfo"]}' 
