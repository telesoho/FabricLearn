noteln "Register ids for peer1 node"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin

infoln "Registering tls client id peer1-sdl on $ROOT_TLS_CA_SERVER"
fabric-ca-client register -u https://$ROOT_TLS_CA_SERVER --id.name peer1-sdl --id.secret peer1-sdlpw --id.type client  2>&1 1>&log.txt; ifErrorPause


export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/ca-sdl-admin
CA_SERVER=ca.sdl.localcoin.jp:8054

infoln "Registering peer user peer1-sdl on $CA_SERVER"
fabric-ca-client register --caname ca-sdl --id.name peer1-sdl --id.secret peer1-sdlpw --id.type peer 2>&1 1>&log.txt; ifErrorPause

