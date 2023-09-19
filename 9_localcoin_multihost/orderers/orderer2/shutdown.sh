. 00_setup_env.sh
infoln "Shutdown all services"
docker-compose down -v
rm -rf fabric-ca-client
rm log.txt