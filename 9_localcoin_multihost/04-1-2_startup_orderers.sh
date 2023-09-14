#!/bin/bash
noteln "Start up orderers"
docker-compose up -d orderer0.orderer.localcoin.jp orderer1.orderer.localcoin.jp orderer2.orderer.localcoin.jp
