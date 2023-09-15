pushd . 2>&1 1>&/dev/null
cd couchdb
. startup.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd ca-servers
. startup.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd peers/peer0
. startup.sh
popd 2>&1 1>&/dev/null


pushd . 2>&1 1>&/dev/null
cd orderers/orderer0
. startup.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd chaincodes
. startup.sh
popd 2>&1 1>&/dev/null

pushd . 2>&1 1>&/dev/null
cd peers/peer1
. startup.sh
popd 2>&1 1>&/dev/null

wait 8

pushd . 2>&1 1>&/dev/null
cd chaincodes
. 31_install_chaincode_to_peer1.sh
popd 2>&1 1>&/dev/null

dirs -c

