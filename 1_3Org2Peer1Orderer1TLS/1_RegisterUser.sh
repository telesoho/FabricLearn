#!/bin/bash -eu
infoln "Working on council"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/council.ifantasy.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/council.ifantasy.net/ca/admin

fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@council.ifantasy.net:7050 2>&1 1>&log.txt
ifErrorPause

fabric-ca-client register -d --id.name orderer1 --id.secret orderer1 --id.type orderer -u https://council.ifantasy.net:7050 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name peer1soft --id.secret peer1soft --id.type peer -u https://council.ifantasy.net:7050 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name peer1web --id.secret peer1web --id.type peer -u https://council.ifantasy.net:7050 2>&1 1>&log.txt
ifErrorPause

infoln "Working on orderer"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/orderer.ifantasy.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/orderer.ifantasy.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@orderer.ifantasy.net:7150 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name orderer1 --id.secret orderer1 --id.type orderer -u https://orderer.ifantasy.net:7150 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://orderer.ifantasy.net:7150 2>&1 1>&log.txt
ifErrorPause

infoln "Working on soft"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/soft.ifantasy.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/soft.ifantasy.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@soft.ifantasy.net:7250 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name peer1 --id.secret peer1 --id.type peer -u https://soft.ifantasy.net:7250 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://soft.ifantasy.net:7250 2>&1 1>&log.txt
ifErrorPause

infoln "Working on web"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$LOCAL_CA_PATH/web.ifantasy.net/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$LOCAL_CA_PATH/web.ifantasy.net/ca/admin
fabric-ca-client enroll -d -u https://ca-admin:ca-adminpw@web.ifantasy.net:7350 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name peer1 --id.secret peer1 --id.type peer -u https://web.ifantasy.net:7350 2>&1 1>&log.txt
ifErrorPause
fabric-ca-client register -d --id.name admin1 --id.secret admin1 --id.type admin -u https://web.ifantasy.net:7350 2>&1 1>&log.txt
ifErrorPause

infoln "All CA and registration done"
