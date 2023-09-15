. 00_setup_env.sh
infoln "Shutdown all services"
docker-compose down -v
infoln "Remove all data..."
rm -rf fabric-ca-client
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/ca.orderer.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/tlsca.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/ca.sdl.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
rm log.txt
