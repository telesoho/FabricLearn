noteln "Register ids for orderer0 node"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin

infoln "Registering tls client id orderer0 on $CA_TLS_LOCALCOIN"
fabric-ca-client register --caname tlsca --id.name orderer0 --id.secret orderer0pw --id.type client  2>&1 1>&log.txt; ifErrorPause

infoln "Registering tls client id orderer1 on $CA_TLS_LOCALCOIN"
fabric-ca-client register --caname tlsca --id.name orderer1 --id.secret orderer1pw --id.type client  2>&1 1>&log.txt; ifErrorPause

infoln "Registering tls client id orderer2 on $CA_TLS_LOCALCOIN"
fabric-ca-client register --caname tlsca --id.name orderer2 --id.secret orderer2pw --id.type client  2>&1 1>&log.txt; ifErrorPause

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users/ca-orderer-admin

infoln "Registering orderer0 on $CA_ORDERER_LOCALCOIN"
fabric-ca-client register --caname ca-orderer --id.name orderer0 --id.secret orderer0pw --id.type orderer 2>&1 1>&log.txt; ifErrorPause

infoln "Registering orderer1 on $CA_ORDERER_LOCALCOIN"
fabric-ca-client register --caname ca-orderer --id.name orderer1 --id.secret orderer1pw --id.type orderer 2>&1 1>&log.txt; ifErrorPause

infoln "Registering orderer2 on $CA_ORDERER_LOCALCOIN"
fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret orderer2pw --id.type orderer 2>&1 1>&log.txt; ifErrorPause
