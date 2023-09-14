# Register and enroll the organization CA bootstrap identity with the TLS CA
export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin

infoln "Register the organization CA bootstrap identity"
fabric-ca-client register -u https://$ROOT_TLS_CA_SERVER --id.name ca-sdl-admin --id.secret ca-sdl-adminpw --id.type client \
    2>&1 1>&log.txt
ifErrorPause

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/ca-sdl-admin
infoln "Enroll the organization CA bootstrap identity with the TLS CA"
fabric-ca-client enroll -d -u https://ca-sdl-admin:ca-sdl-adminpw@$ROOT_TLS_CA_SERVER \
    --enrollment.profile tls --csr.hosts '*.sdl.localcoin.jp' 2>&1 1>&log.txt
ifErrorPause

mkdir -p $LOCAL_ROOT_PATH/fabric-ca-server/ca.sdl.localcoin.jp/tls/ca-sdl-admin
cp $FABRIC_CA_CLIENT_HOME/msp/signcerts/* $LOCAL_ROOT_PATH/fabric-ca-server/ca.sdl.localcoin.jp/tls/ca-sdl-admin/cert.pem
ifErrorPause
cp $FABRIC_CA_CLIENT_HOME/msp/keystore/* $LOCAL_ROOT_PATH/fabric-ca-server/ca.sdl.localcoin.jp/tls/ca-sdl-admin/key.pem
ifErrorPause

infoln "The organization CA TLS signed certificate has been copied to:"
tree $LOCAL_ROOT_PATH/fabric-ca-server/ca.sdl.localcoin.jp/tls
