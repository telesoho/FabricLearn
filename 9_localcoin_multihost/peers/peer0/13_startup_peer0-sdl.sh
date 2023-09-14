#!/bin/bash
noteln "Start up peer0.sdl.localcoin.jp"
pushd . 2>&1 1>&/dev/null
docker-compose up -d peer0.sdl.localcoin.jp
popd 2>&1 1>&/dev/null