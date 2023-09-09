#!/bin/bash
noteln "Start up ca.orderer.localcoin.jp"
docker-compose up -d ca.orderer.localcoin.jp
wait 6

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/ca-orderer-admin

infoln "Enroll ca-ordcerer-admin on $CA_ORDERER_LOCALCOIN"
fabric-ca-client enroll -d -u https://ca-orderer-admin:ca-orderer-adminpw@$CA_ORDERER_LOCALCOIN --caname ca-orderer 2>&1 1>&log.txt; ifErrorPause

noteln "Generating orderer org certificates for docker"
echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orderer-localcoin-jp-7054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml