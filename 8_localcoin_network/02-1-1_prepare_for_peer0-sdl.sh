noteln "Generating peer0-sdl msp"
export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/peer0-sdl

fabric-ca-client enroll -d -u https://peer0-sdl:peer0-sdlpw@$CA_SDL_LOCALCOIN --csr.hosts peer0.sdl.localcoin.jp 2>&1 1>&log.txt; ifErrorPause

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml

infoln "Enroll peer0 tls information => tls"
fabric-ca-client enroll -d -u https://peer0-sdl:peer0-sdlpw@$ROOT_TLS_CA_SERVER --enrollment.profile tls --csr.hosts peer0.sdl.localcoin.jp -M tls 2>&1 1>&log.txt; ifErrorPause

# infoln "Enroll admin1 => admin1/msp"
# fabric-ca-client enroll -d -u https://admin1:admin1pw@$CA_SERVER -M admin1/msp 2>&1 1>&log.txt
# ifErrorPause "Failed to enroll ..."

# # see: https://hyperledger-fabric-ca.readthedocs.io/en/latest/operations_guide.html#enroll-org1-s-admin
# infoln "Copy admin1/msp/signcerts/cert.pem => peer0-sdl/msp/admincerts/admin-cert.pem"
# mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
# cp $FABRIC_CA_CLIENT_HOME/admin1/msp/signcerts/cert.pem $FABRIC_CA_CLIENT_HOME/msp/admincerts/ 2>&1 1>&log.txt
# ifErrorPause "Failed to copy ..."

# see:https://hyperledger-fabric-ca.readthedocs.io/en/latest/operations_guide.html#create-genesis-block-and-channel-transaction
infoln "Copy tls/tlscacerts => msp/tlscacerts"
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/msp/tlscacerts/ 2>&1 1>&log.txt; ifErrorPause "Failed to copy ..."

infoln "Generating the peer0-tls certificates for docker"
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt
cp $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt
cp $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key

infoln "Copy local tls => Org MSP"
ORG_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/ca-sdl-admin

mkdir -p ${ORG_HOME}/msp/tlscacerts
cat ${FABRIC_CA_CLIENT_HOME}/tls/tlscacerts/* >>${ORG_HOME}/msp/tlscacerts/ca.crt


infoln "Copy config/core.yaml"
cp $LOCAL_ROOT_PATH/config/core.yaml $FABRIC_CA_CLIENT_HOME/core.yaml
ifErrorPause

noteln "Show the result:"
tree $FABRIC_CA_CLIENT_HOME
