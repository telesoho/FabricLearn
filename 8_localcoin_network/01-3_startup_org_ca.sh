#!/bin/bash
noteln "Start up ca.sdl.localcoin.jp organization CA"
docker-compose up -d ca.sdl.localcoin.jp
wait 6

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/ca-sdl-admin

infoln "Enroll ca-sdl-admin on $CA_SDL_LOCALCOIN"
fabric-ca-client enroll -d -u https://ca-sdl-admin:ca-sdl-adminpw@$CA_SDL_LOCALCOIN --caname ca-sdl 2>&1 1>&log.txt; ifErrorPause

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
