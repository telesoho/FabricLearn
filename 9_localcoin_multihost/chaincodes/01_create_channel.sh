. env_peer0.sh

CHANNELS_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/channels

infoln "Copy signed key for discover tool"
cp $CORE_PEER_MSPCONFIGPATH/keystore/* $CORE_PEER_MSPCONFIGPATH/keystore.key

infoln "Generate configtx for sdlchannel ..."
configtxgen -profile SdlChannel --outputCreateChannelTx $CHANNELS_FOLDER/sdlchannel.tx -channelID sdlchannel \
  -configPath $LOCAL_ROOT_PATH/config 2>&1 1>&log.txt; ifErrorPause "Failed to generate configtx ..."

infoln "Create sdlchannel"
peer channel create --outputBlock $CHANNELS_FOLDER/sdlchannel.block -c sdlchannel -f $CHANNELS_FOLDER/sdlchannel.tx \
  -o $ORDERER --tls --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES 2>&1 1>&log.txt; ifErrorPause

infoln "Join Peer 0 Node to the Channel"
peer channel join -b $CHANNELS_FOLDER/sdlchannel.block -o $ORDERER --cafile $FABRIC_CA_CLIENT_TLS_CERTFILES --tls 2>&1 1>&log.txt; ifErrorPause

noteln "Show the result:"
tree $CHANNELS_FOLDER
