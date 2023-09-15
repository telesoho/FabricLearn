#!/bin/bash
noteln "Start up ca.sdl.localcoin.jp organization CA"
docker-compose up -d ca.sdl.localcoin.jp
wait 6

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

infoln "Registering org sdl-admin on $CA_SDL_LOCALCOIN"
fabric-ca-client register --caname ca-sdl --id.name sdl-admin --id.secret sdl-adminpw --id.type admin \
  --id.attrs 'hf.Registrar.Roles=*,hf.Registrar.DelegateRoles=*,hf.Revoker=true,hf.IntermediateCA=true,hf.GenCRL=true,hf.Registrar.Attributes=*,hf.AffiliationMgr=true' \
  2>&1 1>&log.txt
ifErrorPause

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
