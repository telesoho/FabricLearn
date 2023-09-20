# Setup Orderers
noteln "Generating orderer0 certificates for docker"
export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer0

fabric-ca-client enroll -d -u https://orderer0:orderer0pw@$CA_ORDERER_LOCALCOIN --csr.hosts orderer0.orderer.localcoin.jp 2>&1 1>&log.txt; ifErrorPause

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml

infoln "Enroll orderer0 tls infomation => tls"
fabric-ca-client enroll -d -u https://orderer0:orderer0pw@$CA_TLS_LOCALCOIN --enrollment.profile tls --csr.hosts orderer0.orderer.localcoin.jp \
  -M tls 2>&1 1>&log.txt; ifErrorPause


# https://hyperledger-fabric.readthedocs.io/en/release-2.2/deployorderer/ordererdeploy.html#tls-certificates
infoln "Copy the TLS CA Root certificate, which by default is called ca-cert.pem, to the orderer organization MSP definition"
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/msp/tlscacerts/ 2>&1 1>&log.txt; ifErrorPause

infoln "Generating Orderer0 local MSP (enrollment certificate and private key of the orderer)"
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key 2>&1 1>&log.txt; ifErrorPause

infoln "Append local tls => Org MSP"
ORG_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/ca-orderer-admin

mkdir -p ${ORG_HOME}/msp/tlscacerts
cat ${FABRIC_CA_CLIENT_HOME}/tls/tlscacerts/* >>${ORG_HOME}/msp/tlscacerts/ca.crt

infoln "Copy config/orderer.yaml to local MSP folder"
cp $PROJECT_ROOT/config/orderer.yaml $FABRIC_CA_CLIENT_HOME/orderer.yaml 2>&1 1>&log.txt; ifErrorPause

noteln "Show the result:"
tree $FABRIC_CA_CLIENT_HOME

noteln "Generating orderer1 certificates for docker"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer1


fabric-ca-client enroll -d -u https://orderer1:orderer1pw@$CA_ORDERER_LOCALCOIN --csr.hosts orderer1.orderer.localcoin.jp 2>&1 1>&log.txt; ifErrorPause

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml

infoln "Enroll orderer1 tls infomation => tls"
fabric-ca-client enroll -d -u https://orderer1:orderer1pw@$CA_TLS_LOCALCOIN --enrollment.profile tls --csr.hosts orderer1.orderer.localcoin.jp \
  -M tls 2>&1 1>&log.txt; ifErrorPause


# https://hyperledger-fabric.readthedocs.io/en/release-2.2/deployorderer/ordererdeploy.html#tls-certificates
infoln "Copy the TLS CA Root certificate, which by default is called ca-cert.pem, to the orderer organization MSP definition"
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/msp/tlscacerts/ 2>&1 1>&log.txt; ifErrorPause

infoln "Generating Orderer1 local MSP (enrollment certificate and private key of the orderer)"
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key 2>&1 1>&log.txt; ifErrorPause

infoln "Append local tls => Org MSP"
ORG_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/ca-orderer-admin

mkdir -p ${ORG_HOME}/msp/tlscacerts
cat ${FABRIC_CA_CLIENT_HOME}/tls/tlscacerts/* >>${ORG_HOME}/msp/tlscacerts/ca.crt

infoln "Copy config/orderer.yaml to local MSP folder"
cp $PROJECT_ROOT/config/orderer.yaml $FABRIC_CA_CLIENT_HOME/orderer.yaml 2>&1 1>&log.txt; ifErrorPause

noteln "Show the result:"
tree $FABRIC_CA_CLIENT_HOME

noteln "Generating orderer2 certificates for docker"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer2


fabric-ca-client enroll -d -u https://orderer2:orderer2pw@$CA_ORDERER_LOCALCOIN --csr.hosts orderer2.orderer.localcoin.jp 2>&1 1>&log.txt; ifErrorPause

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml

infoln "Enroll orderer2 tls infomation => tls"
fabric-ca-client enroll -d -u https://orderer2:orderer2pw@$CA_TLS_LOCALCOIN --enrollment.profile tls --csr.hosts orderer2.orderer.localcoin.jp \
  -M tls 2>&1 1>&log.txt; ifErrorPause


# https://hyperledger-fabric.readthedocs.io/en/release-2.2/deployorderer/ordererdeploy.html#tls-certificates
infoln "Copy the TLS CA Root certificate, which by default is called ca-cert.pem, to the orderer organization MSP definition"
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/msp/tlscacerts/ 2>&1 1>&log.txt; ifErrorPause

infoln "Generating Orderer2 local MSP (enrollment certificate and private key of the orderer)"
cp $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt 2>&1 1>&log.txt; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key 2>&1 1>&log.txt; ifErrorPause

infoln "Append local tls => Org MSP"
ORG_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/ca-orderer-admin

mkdir -p ${ORG_HOME}/msp/tlscacerts
cat ${FABRIC_CA_CLIENT_HOME}/tls/tlscacerts/* >>${ORG_HOME}/msp/tlscacerts/ca.crt

infoln "Copy config/orderer.yaml to local MSP folder"
cp $PROJECT_ROOT/config/orderer.yaml $FABRIC_CA_CLIENT_HOME/orderer.yaml 2>&1 1>&log.txt; ifErrorPause

noteln "Show the result:"
tree $FABRIC_CA_CLIENT_HOME

noteln "Generate configtx for system-channel..."

configtxgen -profile OrgsOrdererGenesis -outputBlock $LOCAL_ROOT_PATH/fabric-ca-client/system-channel/genesis.block \
  -channelID system-channel -configPath $LOCAL_ROOT_PATH/config 2>&1 1>&log.txt
ifErrorPause "Failed to generate configtx ..."

infoln "Copy system-channel.genesis.block => local MSP"

CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer0
mkdir -p $CA_CLIENT_HOME/system-channel
cp $LOCAL_ROOT_PATH/fabric-ca-client/system-channel/genesis.block $CA_CLIENT_HOME/system-channel/genesis.block

CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer1
mkdir -p $CA_CLIENT_HOME/system-channel
cp $LOCAL_ROOT_PATH/fabric-ca-client/system-channel/genesis.block $CA_CLIENT_HOME/system-channel/genesis.block

CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer2
mkdir -p $CA_CLIENT_HOME/system-channel
cp $LOCAL_ROOT_PATH/fabric-ca-client/system-channel/genesis.block $CA_CLIENT_HOME/system-channel/genesis.block

noteln "Upload genesis.block => ftp server"
USER_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users

ncftpput -u sdl -p sdlpw -P 2021 -R -m ftp.localcoin.jp /orderers \
  $USER_FOLDER/orderer0 \
  $USER_FOLDER/orderer1 \
  $USER_FOLDER/orderer2
ifErrorPause

