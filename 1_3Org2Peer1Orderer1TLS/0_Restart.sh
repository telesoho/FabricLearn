#!/bin/bash -u
source env.sh
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
rm -rf orgs data
docker-compose up -d council.ifantasy.net orderer.ifantasy.net soft.ifantasy.net web.ifantasy.net
