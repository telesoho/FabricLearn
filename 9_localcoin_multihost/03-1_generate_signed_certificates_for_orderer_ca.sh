# Register and enroll the organization CA bootstrap identity with the TLS CA
export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin

# infoln "Register the organization CA bootstrap identity"
fabric-ca-client register -u https://$ROOT_TLS_CA_SERVER --id.name ca-orderer-admin --id.secret ca-orderer-adminpw \
    --id.type client 2>&1 1>&log.txt; ifErrorPause

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/ca-orderer-admin

infoln "Enroll the orderer CA bootstrap identity with the TLS CA"
fabric-ca-client enroll -d -u https://ca-orderer-admin:ca-orderer-adminpw@$ROOT_TLS_CA_SERVER \
    --enrollment.profile tls --csr.hosts '*.orderer.localcoin.jp' 2>&1 1>&log.txt; ifErrorPause

mkdir -p $LOCAL_ROOT_PATH/fabric-ca-server/ca.orderer.localcoin.jp/tls/ca-orderer-admin
cp $FABRIC_CA_CLIENT_HOME/msp/signcerts/* $LOCAL_ROOT_PATH/fabric-ca-server/ca.orderer.localcoin.jp/tls/ca-orderer-admin/cert.pem ; ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/msp/keystore/* $LOCAL_ROOT_PATH/fabric-ca-server/ca.orderer.localcoin.jp/tls/ca-orderer-admin/key.pem ; ifErrorPause

noteln "The orderer CA TLS signed certificate is generated here:"
tree $FABRIC_CA_CLIENT_HOME