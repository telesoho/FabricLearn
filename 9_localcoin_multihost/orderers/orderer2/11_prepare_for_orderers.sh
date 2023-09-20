noteln "Download orderers folder from ftp server"
USER_FOLDER=$LOCAL_ROOT_PATH/fabric-ca-client/ca.orderer.localcoin.jp/users
mkdir -p $USER_FOLDER
ncftpget -u sdl -p sdlpw -P 2021 -R ftp.localcoin.jp $USER_FOLDER /orderers/orderer2
ifErrorPause

