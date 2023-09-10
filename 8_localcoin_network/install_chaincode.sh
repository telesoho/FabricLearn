CC_NAME=odoo-user
CC_VERSION=1.0
CC_SEQUENCE=1
CC_INIT_FCN=
CHANNEL=sdlchannel

INIT_REQUIRED="--init-required"
# check if the init fcn should be called
if [ "$CC_INIT_FCN" = "" ]; then
  INIT_REQUIRED=""
fi

infoln "Install the Package"
peer lifecycle chaincode install ${CC_NAME}.tar.gz 2>&1 1>&log.txt; ifErrorPause

infoln "Verify the Package"
peer lifecycle chaincode queryinstalled 2>&1 1>&log.txt
CC_PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt); ifErrorPause
cat log.txt

if [ "$1" = "install-only" ]; then
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
