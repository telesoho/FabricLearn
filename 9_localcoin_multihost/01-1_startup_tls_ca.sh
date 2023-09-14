#!/bin/bash
noteln "Start up tlsca.localcoin.jp CA server"
docker-compose up -d tlsca.localcoin.jp
wait 5

mkdir -p $LOCAL_ROOT_PATH/fabric-ca-client

FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_ROOT_PATH/fabric-ca-client/tls-ca-cert.pem

cp $LOCAL_ROOT_PATH/fabric-ca-server/tlsca.localcoin.jp/ca-cert.pem $FABRIC_CA_CLIENT_TLS_CERTFILES; ifErrorPause

infoln "Root TLS CA has been copied to $FABRIC_CA_CLIENT_TLS_CERTFILES"

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CA_CLIENT_TLS_CERTFILES
export ROOT_TLS_CA_SERVER="$CA_TLS_LOCALCOIN"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin
infoln "Enroll bootstrap admin identity with TLS CA"
fabric-ca-client enroll -d -u https://tls-admin:tls-adminpw@$ROOT_TLS_CA_SERVER --enrollment.profile tls 2>&1 1>&log.txt; ifErrorPause
