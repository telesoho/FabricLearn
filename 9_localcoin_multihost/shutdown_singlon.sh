. ../utils.sh
. ../version.sh

infoln "Shutdown all services"
docker-compose down -v 2>&1 1>&/dev/null

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

pushd . 2>&1 1>&/dev/null
cd couchdb
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd ca-servers
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd peers/peer0
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd peers/peer1
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd orderers/orderer0
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd chaincodes
. shutdown.sh 2>&1 1>&/dev/null
popd 2>&1 1>&/dev/null

dirs -c

docker container prune -f 2>&1 1>&/dev/null
docker volume prune -f 2>&1 1>&/dev/null
docker rm $(docker ps -a -f status=exited -f status=created -q) 2>&1 1>&/dev/null
# removeUnwantedImages

docker volume ls