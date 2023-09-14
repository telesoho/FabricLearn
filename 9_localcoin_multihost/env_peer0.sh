. 00_setup_env.sh
export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/sdl-admin

export FABRIC_LOGGING_SPEC=debug # Set logging level to debug for more verbose logging
export CORE_PEER_ID=cli
export CORE_CHAINCODE_KEEPALIVE=10
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=$FABRIC_CA_CLIENT_TLS_CERTFILES
export CORE_PEER_LOCALMSPID=sdlMSP
export CORE_PEER_MSPCONFIGPATH=$FABRIC_CA_CLIENT_HOME/msp
export CORE_PEER_ADDRESS=peer0.sdl.localcoin.jp:7051
export FABRIC_CFG_PATH=$LOCAL_ROOT_PATH/config
export ORDERER=orderer0.orderer.localcoin.jp:7050
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.sdl.localcoin.jp:7051
