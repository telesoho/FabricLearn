#!/bin/bash -eu
infoln "Preparation============================="
mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/assets
cp $LOCAL_CA_PATH/orderer.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/assets
cp $LOCAL_CA_PATH/soft.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/assets
cp $LOCAL_CA_PATH/web.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/assets/tls-ca-cert.pem
infoln "Preparation============================="

infoln "Start orderer============================="
infoln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/orderer.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@orderer.ifantasy.net:7150 2>&1 1>&log.txt
ifErrorPause

# 加入通道时会用到admin/msp，其下必须要有admincers
mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

infoln "Enroll Orderer"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/orderer.ifantasy.net/registers/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/orderer.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer1:orderer1@orderer.ifantasy.net:7150 2>&1 1>&log.txt
ifErrorPause

mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/registers/orderer1/msp/admincerts
cp $LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/registers/orderer1/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/orderer.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer1:orderer1@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts orderer1.orderer.ifantasy.net 2>&1 1>&log.txt
ifErrorPause
cp $LOCAL_CA_PATH/orderer.ifantasy.net/registers/orderer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/orderer.ifantasy.net/registers/orderer1/tls-msp/keystore/key.pem

mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/orderer.ifantasy.net/msp/users
cp $LOCAL_CA_PATH/orderer.ifantasy.net/assets/ca-cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/msp/cacerts/
cp $LOCAL_CA_PATH/orderer.ifantasy.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/orderer.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/orderer.ifantasy.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/orderer.ifantasy.net/msp/config.yaml
infoln "End orderer============================="

infoln "Start Soft============================="
infoln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@soft.ifantasy.net:7250 2>&1 1>&log.txt
ifErrorPause
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

infoln "Enroll Peer1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@soft.ifantasy.net:7250 2>&1 1>&log.txt
ifErrorPause
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1soft:peer1soft@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts peer1.soft.ifantasy.net 2>&1 1>&log.txt
ifErrorPause
cp $LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/msp/users
cp $LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/msp/cacerts/
cp $LOCAL_CA_PATH/soft.ifantasy.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/soft.ifantasy.net/msp/config.yaml
infoln "End Soft============================="

infoln "Start Web============================="
infoln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/web.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@web.ifantasy.net:7350 2>&1 1>&log.txt
ifErrorPause
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

infoln "Enroll Peer1"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/web.ifantasy.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@web.ifantasy.net:7350 2>&1 1>&log.txt
ifErrorPause
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1web:peer1web@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts peer1.web.ifantasy.net 2>&1 1>&log.txt
ifErrorPause
cp $LOCAL_CA_PATH/web.ifantasy.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/web.ifantasy.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/web.ifantasy.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/msp/users
cp $LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/msp/cacerts/
cp $LOCAL_CA_PATH/web.ifantasy.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/web.ifantasy.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/web.ifantasy.net/msp/config.yaml
infoln "End Web============================="
