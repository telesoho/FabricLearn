. ../utils.sh
. ../version.sh

infoln "Shutdown all services"
docker-compose down -v
infoln "Remove all data..."
rm -rf data
rm -rf fabric-ca-client
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/ca.orderer.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/tlsca.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && find fabric-ca-server/ca.sdl.localcoin.jp/. ! -name 'fabric-ca-server-config.yaml' ! -name '.gitignore' ! -name '..' ! -name '.'  -exec rm -rf {} +'
# docker run --rm -v $(pwd):/data busybox sh -c 'cd /data && rm -rf fabric-ca-client'
rm log.txt

# Delete any images that were generated as a part of this setup
# specifically the following images are often left behind:
# This function is called when you bring the network down
function removeUnwantedImages() {
    DOCKER_IMAGE_IDS=$(docker images | awk '($1 ~ /dev-peer.*/) {print $3}')
    if [ -z "$DOCKER_IMAGE_IDS" -o "$DOCKER_IMAGE_IDS" == " " ]; then
        infoln "No images available for deletion"
    else
        docker rmi -f $DOCKER_IMAGE_IDS
    fi
}

docker container prune -f 2>&1 1>&/dev/null
docker volume prune -f 2>&1 1>&/dev/null
docker rm $(docker ps -a -f status=exited -f status=created -q) 2>&1 1>&/dev/null
# removeUnwantedImages

pushd . 2>&1 1>&/dev/null
cd peers/peer0
. shutdown.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd peers/peer1
. shutdown.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd orderers/orderer0
. shutdown.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd chaincodes
. shutdown.sh
popd 2>&1 1>&/dev/null

dirs -c

docker volume ls