#!/bin/bash -eu
noteln "Preparation============================="
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/assets
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/council.ifantasy.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/assets
cp $LOCAL_CA_PATH/soft.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/assets 
cp $LOCAL_CA_PATH/web.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/web.ifantasy.net/assets/tls-ca-cert.pem

mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/assets
cp $LOCAL_CA_PATH/hard.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/assets/ca-cert.pem
cp $LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/assets/tls-ca-cert.pem
noteln "Preparation end=========================="

noteln "Start Council============================="
noteln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@council.ifantasy.net:7050  2>&1 1>&log.txt; ifErrorPause
# 加入通道时会用到admin/msp，其下必须要有admincers
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

noteln "Enroll Orderer1"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.ifantasy.net/registers/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer1:orderer1@council.ifantasy.net:7050  2>&1 1>&log.txt
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer1/msp/admincerts
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer1/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer1:orderer1@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts orderer1.council.ifantasy.net 2>&1 1>&log.txt; ifErrorPause
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer1/tls-msp/keystore/key.pem

noteln "Enroll Orderer2"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.ifantasy.net/registers/orderer2
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer2:orderer2@council.ifantasy.net:7050  2>&1 1>&log.txt
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer2/msp/admincerts
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer2/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer2:orderer2@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts orderer2.council.ifantasy.net 2>&1 1>&log.txt; ifErrorPause
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer2/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer2/tls-msp/keystore/key.pem

noteln "Enroll Orderer3"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.ifantasy.net/registers/orderer3
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://orderer3:orderer3@council.ifantasy.net:7050  2>&1 1>&log.txt
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer3/msp/admincerts
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer3/msp/admincerts/cert.pem
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://orderer3:orderer3@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts orderer3.council.ifantasy.net 2>&1 1>&log.txt; ifErrorPause 
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer3/tls-msp/keystore/*_sk $LOCAL_CA_PATH/council.ifantasy.net/registers/orderer3/tls-msp/keystore/key.pem

mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/council.ifantasy.net/msp/users
cp $LOCAL_CA_PATH/council.ifantasy.net/assets/ca-cert.pem $LOCAL_CA_PATH/council.ifantasy.net/msp/cacerts/
cp $LOCAL_CA_PATH/council.ifantasy.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/council.ifantasy.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/council.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/council.ifantasy.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/council.ifantasy.net/msp/config.yaml
noteln "End council============================="


noteln "Start Soft============================="
noteln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@soft.ifantasy.net:7250 2>&1 1>&log.txt; ifErrorPause
mkdir -p $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/soft.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

noteln "Enroll Peer1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/soft.ifantasy.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@soft.ifantasy.net:7250 2>&1 1>&log.txt; ifErrorPause
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1soft:peer1soft@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts peer1.soft.ifantasy.net 2>&1 1>&log.txt; ifErrorPause
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
noteln "End Soft============================="

noteln "Start Web============================="
noteln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/web.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@web.ifantasy.net:7350 2>&1 1>&log.txt; ifErrorPause
mkdir -p $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/web.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

noteln "Enroll Peer1"
# for identity
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/web.ifantasy.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@web.ifantasy.net:7350 2>&1 1>&log.txt; ifErrorPause
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1web:peer1web@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts peer1.web.ifantasy.net 2>&1 1>&log.txt; ifErrorPause
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
noteln "End Web============================="

noteln "Start Hard============================="
noteln "Enroll Admin"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/hard.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin1:admin1@hard.ifantasy.net:7450 2>&1 1>&log.txt; ifErrorPause
mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1/msp/admincerts
cp $LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1/msp/admincerts/cert.pem

noteln "Enroll Peer1"
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/hard.ifantasy.net/registers/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/hard.ifantasy.net/assets/ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer1:peer1@hard.ifantasy.net:7450 2>&1 1>&log.txt; ifErrorPause
# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/hard.ifantasy.net/assets/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1hard:peer1hard@council.ifantasy.net:7050 --enrollment.profile tls --csr.hosts peer1.hard.ifantasy.net 2>&1 1>&log.txt; ifErrorPause
cp $LOCAL_CA_PATH/hard.ifantasy.net/registers/peer1/tls-msp/keystore/*_sk $LOCAL_CA_PATH/hard.ifantasy.net/registers/peer1/tls-msp/keystore/key.pem
mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/registers/peer1/msp/admincerts
cp $LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/registers/peer1/msp/admincerts/cert.pem

mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/msp/admincerts
mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/msp/cacerts
mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/msp/tlscacerts
mkdir -p $LOCAL_CA_PATH/hard.ifantasy.net/msp/users
cp $LOCAL_CA_PATH/hard.ifantasy.net/assets/ca-cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/msp/cacerts/
cp $LOCAL_CA_PATH/hard.ifantasy.net/assets/tls-ca-cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/msp/tlscacerts/
cp $LOCAL_CA_PATH/hard.ifantasy.net/registers/admin1/msp/signcerts/cert.pem $LOCAL_CA_PATH/hard.ifantasy.net/msp/admincerts/cert.pem
cp $LOCAL_ROOT_PATH/config/config-msp.yaml $LOCAL_CA_PATH/hard.ifantasy.net/msp/config.yaml
noteln "End Hard============================="