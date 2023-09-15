#!/bin/bash
CC_NAME=
CC_SRC_PATH=
CC_SRC_LANGUAGE=javascript
CC_VERSION=1.0
CC_SEQUENCE=1
CC_INIT_FCN=
CC_INIT_FCN_ARGS="[]"
CHANNEL=sdlchannel
NOCOMMIT=FALSE

USAGE="USAGE: install_chaincode [OPTIONS]
Options:
-n, --name      chaincode name
-s, --src       chaincode source path
-l, --lang      chaincode language
-v, --version   chaincode version
-q, --sequence  chaincode sequence
-f, --init_fcn  chaincode init function name
-a, --args      chaincode init function args
-c, --channel   channel name
-m, --nocommit  install package only, donot commit to channel

Example:
. install_chaincode -n chaincode_test --src ../src
"

UNKNOWN=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -n | --name)
    CC_NAME="$2"
    shift # past argument
    shift # past value
    ;;
  -s | --src)
    CC_SRC_PATH="$2"
    shift # past argument
    shift # past value
    ;;
  -l | --lang)
    CC_SRC_LANGUAGE="$2"
    shift # past argument
    shift # past value
    ;;
  -v | --version)
    CC_VERSION="$2"
    shift # past argument
    shift # past value
    ;;
  -q | --sequence)
    CC_SEQUENCE="$2"
    shift # past argument
    shift # past value
    ;;
  -f | --init_fcn)
    CC_INIT_FCN="$2"
    shift # past argument
    shift # past value
    ;;
  -a | --args)
    CC_INIT_FCN_ARGS="$2"
    shift # past argument
    shift # past value
    ;;
  -c | --channel)
    CHANNEL="$2"
    shift # past argument
    shift # past value
    ;;
  -c | --nocommit)
    NOCOMMIT="$2"
    shift # past argument
    shift # past value
    ;;
  *) # unknown option
    UNKNOWN+=("$1")
    shift # past argument
    echo "${USAGE}"
    echo "ERROR: Unknown options ${UNKNOWN[@]}"
    return -1
    ;;
  esac
done

if [ "${CC_NAME}" = "" ]; then
  echo "${USAGE}"
  return -1
fi

if [ "${CC_SRC_PATH}" = "" ]; then
  echo "${USAGE}"
  return -1
fi

INIT_REQUIRED="--init-required"
# check if the init fcn should be called
if [ "$CC_INIT_FCN" = "" ]; then
  INIT_REQUIRED=""
fi

CC_SRC_LANGUAGE=$(echo "$CC_SRC_LANGUAGE" | tr [:upper:] [:lower:])

# do some language specific preparation to the chaincode before packaging
if [ "$CC_SRC_LANGUAGE" = "javascript" ]; then
  CC_RUNTIME_LANGUAGE=node

elif [ "$CC_SRC_LANGUAGE" = "typescript" ]; then
  CC_RUNTIME_LANGUAGE=node

  infoln "Compiling TypeScript code into JavaScript..."
  pushd $CC_SRC_PATH
  npm install
  npm run build
  popd
  successln "Finished compiling TypeScript code into JavaScript"

else
  fatalln "The chaincode language ${CC_SRC_LANGUAGE} is not supported by this script. Supported chaincode languages are: go, java, javascript, and typescript"
  return 1
fi

infoln "Create package chaincode $CC_NAME .."
peer lifecycle chaincode package ${CC_NAME}.tar.gz --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} --label ${CC_NAME}_${CC_VERSION} 2>&1 1>&log.txt
ifErrorPause

infoln "Install the Package"
peer lifecycle chaincode install ${CC_NAME}.tar.gz 2>&1 1>&log.txt
ifErrorPause

infoln "Verify the Package"
peer lifecycle chaincode queryinstalled 2>&1 1>&log.txt
CC_PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
ifErrorPause
cat log.txt

if [ "$NOCOMMIT" = "TRUE" ]; then
  return
fi

infoln "Approve the Chaincode"
peer lifecycle chaincode approveformyorg \
  --orderer $ORDERER --tls --cafile $CORE_PEER_TLS_ROOTCERT_FILE \
  --channelID $CHANNEL --name $CC_NAME --version $CC_VERSION --sequence $CC_SEQUENCE --package-id $CC_PACKAGE_ID $INIT_REQUIRED 2>&1 1>&log.txt
ifErrorPause

infoln "Check Commit Readiness"
# checkcommitreadiness return always false for approvals
# see: https://github.com/hyperledger/fabric/issues/3330#issuecomment-1230700256
peer lifecycle chaincode checkcommitreadiness \
  --orderer $ORDERER --tls --cafile $CORE_PEER_TLS_ROOTCERT_FILE \
  --channelID $CHANNEL --name $CC_NAME --version $CC_VERSION --sequence $CC_SEQUENCE $INIT_REQUIRED 2>&1 1>&log.txt
ifErrorPause
cat log.txt

infoln "Commit the Chaincode"
peer lifecycle chaincode commit \
  --orderer $ORDERER --tls --cafile $CORE_PEER_TLS_ROOTCERT_FILE \
  --channelID $CHANNEL --name $CC_NAME --version $CC_VERSION --sequence $CC_SEQUENCE $INIT_REQUIRED 2>&1 1>&log.txt
ifErrorPause

infoln "Verify the Chaincode"
peer lifecycle chaincode querycommitted --channelID $CHANNEL 2>&1 1>&log.txt
ifErrorPause
cat log.txt

if [ "$CC_INIT_FCN" != "" ]; then
  infoln "Initialize the Chaincode"
  fcn_call='{"function":"'${CC_INIT_FCN}'","Args":'${CC_INIT_FCN_ARGS}'}'
  peer chaincode invoke --tls --cafile $CORE_PEER_TLS_ROOTCERT_FILE --channelID $CHANNEL --isInit --name $CC_NAME -c $fcn_call 2>&1 1>&log.txt
  ifErrorPause
fi
