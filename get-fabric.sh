#!/bin/bash
. version.sh
. utils.sh

RESOURCES=${1:-binary}

if [ -f install-fabric.sh ]; then
    infoln "install-fabric.sh exist"
else
    infoln "fetch install-fabric.sh ..."
    curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh install-fabric.sh && chmod +x install-fabric.sh
fi

infoln "fetch fabric resource"
. install-fabric.sh --fabric-version $FABRIC_VERSION --ca-version $FABRIC_CA_VERSION $RESOURCES
