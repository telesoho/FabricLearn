#!/bin/bash

mkdir -p $LOCAL_ROOT_PATH/fabric-ca-client

ncftpget -u sdl -p sdlpw -P 2021 -R ftp.localcoin.jp $LOCAL_ROOT_PATH/fabric-ca-client /tls-ca-cert.pem 2>&1 1>&log.txt; ifErrorPause
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_ROOT_PATH/fabric-ca-client/tls-ca-cert.pem

infoln "Root TLS CA has been download to $FABRIC_CA_CLIENT_TLS_CERTFILES"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin
infoln "Enroll bootstrap admin identity with TLS CA"
fabric-ca-client enroll -d -u https://tls-admin:tls-adminpw@$CA_TLS_LOCALCOIN --enrollment.profile tls 2>&1 1>&log.txt; ifErrorPause


export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/ca-sdl-admin

infoln "Enroll ca-sdl-admin on $CA_SDL_LOCALCOIN"
fabric-ca-client enroll -d -u https://ca-sdl-admin:ca-sdl-adminpw@$CA_SDL_LOCALCOIN --caname ca-sdl 2>&1 1>&log.txt
ifErrorPause

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054-ca-sdl.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054-ca-sdl.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054-ca-sdl.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-sdl-localcoin-jp-8054-ca-sdl.pem
    OrganizationalUnitIdentifier: orderer' >${FABRIC_CA_CLIENT_HOME}/msp/config.yaml

# infoln "Registering org sdl-admin on $CA_SDL_LOCALCOIN"
# fabric-ca-client register --caname ca-sdl --id.name sdl-admin --id.secret sdl-adminpw --id.type admin \
#   --id.attrs 'hf.Registrar.Roles=*,hf.Registrar.DelegateRoles=*,hf.Revoker=true,hf.IntermediateCA=true,hf.GenCRL=true,hf.Registrar.Attributes=*,hf.AffiliationMgr=true' \
#   2>&1 1>&log.txt
# ifErrorPause

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/sdl-admin

infoln "Enroll sdl-admin user"
fabric-ca-client enroll -u https://sdl-admin:sdl-adminpw@$CA_SDL_LOCALCOIN --tls.certfiles $FABRIC_CA_CLIENT_TLS_CERTFILES 2>&1 1>&log.txt
ifErrorPause

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


export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/orderer-admin

infoln "Enroll orderer-admin user"
fabric-ca-client enroll -u https://orderer-admin:orderer-adminpw@$CA_ORDERER_LOCALCOIN \
  --tls.certfiles $FABRIC_CA_CLIENT_TLS_CERTFILES 2>&1 1>&log.txt
ifErrorPause

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

