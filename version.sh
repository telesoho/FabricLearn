#!/bin/bash
export FABRIC_VERSION=${FABRIC_VERSION:-2.2.3}
export FABRIC_CA_VERSION=${FABRIC_CA_VERSION:-1.4.7}
export FABRIC_BASE_VERSION=${FABRIC_BASE_VERSION:-2.2.3}

export PROJECT_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [ -d "$PROJECT_ROOT/bin" ]; then
    export PATH="$PROJECT_ROOT/bin:$PATH"
fi

export FABRIC_CFG_PATH="$PROJECT_ROOT/config"

function checkToolVersion() {
    noteln "Check version for Fabric $FABRIC_VERSION & Fabric CA $FABRIC_CA_VERSION"
    export FABRIC_LOGGING_SPEC=info
    ## Check if your have cloned the peer binaries and configuration files.
    peer version >/dev/null 2>&1 1>&log.txt

    if [[ $? -ne 0 || ! -d "../config" ]]; then
        errorln "Peer binary and configuration files not found.."
        errorln "You can use get-fabric.sh to fix it."
        errorln "Follow the instructions in the Fabric docs to install the Fabric Binaries:"
        errorln "https://hyperledger-fabric.readthedocs.io/en/latest/install.html"
        return 1
    fi

    PEER_LOCAL_VERSION=$(peer version | sed -ne 's/^ Version: //p')

    if [ "$PEER_LOCAL_VERSION" != "$FABRIC_VERSION" ]; then
        warnln "Local peer binaries version ($FABRIC_LOCAL_VERSION) not match fabric verison($FABRIC_VERSION). This may cause problems."
        warnln "Use get-fabric.sh to fix it."
        return 2
    fi

    fabric-ca-client version >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        errorln "fabric-ca-client binary not found.."
        errorln "You can use get-fabric.sh to fix it."
        errorln "Follow the instructions in the Fabric docs to install the Fabric Binaries:"
        errorln "https://hyperledger-fabric.readthedocs.io/en/latest/install.html"
        return 1
    fi
    CA_LOCAL_VERSION=$(fabric-ca-client version | sed -ne 's/ Version: //p')

    if [ "$CA_LOCAL_VERSION" != "$FABRIC_CA_VERSION" ]; then
        warnln "Local fabric-ca-client binaries version($CA_LOCAL_VERSION) not match fabirc ca verion($FABRIC_CA_VERSION). This may cause problems."
        return 2
    fi
}
