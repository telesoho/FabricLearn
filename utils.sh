#!/bin/bash

# colors tables see: https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[1;33m'
C_NOTE='\033[0;35m'

# println echos string
function println() {
  echo -e "$1"
}

# errorln echos i red color
function errorln() {
  println "${C_RED}${1}${C_RESET}"
}

# successln echos in green color
function successln() {
  println "${C_GREEN}${1}${C_RESET}"
}

# infoln echos in blue color
function infoln() {
  println "${C_BLUE}${1}${C_RESET}"
}

# warnln echos in yellow color
function warnln() {
  println "${C_YELLOW}${1}${C_RESET}"
}

# fatalln echos in red color and exits with fail status
function fatalln() {
  errorln "$1"
  exit $?
}

function noteln() {
  println "$C_NOTE${1}$C_RESET"
}

export -f errorln
export -f successln
export -f infoln
export -f warnln
export -f noteln

verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}


ifErrorPause() {
  if [ $? -ne 0 ]; then
    errorln "$1"
    if [ -f "log.txt" ]; then
      cat log.txt
    fi
    warnln "Press Ctrl+C to stop, ENTER to continue."
    read
  fi
}

viewCertDetail() {
  openssl x509 -noout -text -subject -issuer -in $1;  
}

viewCert() {
  openssl x509 -noout -subject -issuer -in $1;  
}

function clearContainers() {
  CONTAINER_IDS=$(docker ps -a | awk '($2 ~ /hyperledger.*/) {print $1}')
  if [ -z "$CONTAINER_IDS" -o "$CONTAINER_IDS" == " " ]; then
    infoln "No containers available for deletion"
  else
    docker rm -f $CONTAINER_IDS
  fi
  CONTAINER_IDS=$(docker ps -a | awk '($2 ~ /dev-peer.*/) {print $1}')
  if [ -z "$CONTAINER_IDS" -o "$CONTAINER_IDS" == " " ]; then
    infoln "No containers available for deletion"
  else
    docker rm -f $CONTAINER_IDS
  fi  
}


waitFile() {
  infoln "Waiting for $1"
  i=1
  sp="/-\|"
  while [ ! -f $1 ]
  do
    sleep 1
    printf "\b${sp:i++%${#sp}:1}"
  done
}


wait() {
  infoln "Waiting $1's"
  sleep $1
}

one_line_pem() {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function _trap_DEBUG() {
    echo "# $BASH_COMMAND";
    while read -r -e -p "debug> " _command; do
        if [ -n "$_command" ]; then
            eval "$_command";
        else
            break;
        fi;
    done
}

# trap '_trap_DEBUG' DEBUG
