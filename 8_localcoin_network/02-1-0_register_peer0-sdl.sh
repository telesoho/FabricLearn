noteln "Register ids for peer0 node"

export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/tlsca.localcoin.jp/users/tls-admin

infoln "Registering tls client id peer0-sdl on $ROOT_TLS_CA_SERVER"
fabric-ca-client register -u https://$ROOT_TLS_CA_SERVER --id.name peer0-sdl --id.secret peer0-sdlpw --id.type client  2>&1 1>&log.txt; ifErrorPause


export FABRIC_CA_CLIENT_HOME=$LOCAL_ROOT_PATH/fabric-ca-client/ca.sdl.localcoin.jp/users/ca-sdl-admin

infoln "Registering peer user peer0-sdl on $CA_SDL_LOCALCOIN"
fabric-ca-client register --caname ca-sdl --id.name peer0-sdl --id.secret peer0-sdlpw --id.type peer 2>&1 1>&log.txt; ifErrorPause

