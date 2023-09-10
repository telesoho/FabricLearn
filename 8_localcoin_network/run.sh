. 99_remove_all.sh
. 00_setup_env.sh
. 01-1_startup_tls_ca.sh
wait 8
. 01-2_generate_signed_certificates_for_orgs_ca.sh
. 01-3_startup_org_ca.sh
wait 5
. 02-1-0_register_peer0-sdl.sh
. 02-1-1_prepare_for_peer0-sdl.sh
. 02-1-2_startup_peer0-sdl.sh
# 如果在这个时候构建Peer1,会导致后面无法安装Chaincode的问题
# . 02-2-0_register_peer1-sdl.sh
# . 02-2-1_prepare_for_peer1-sdl.sh
# . 02-2-2_startup_peer1-sdl.sh
wait 5
. 03-1_generate_signed_certificates_for_orderer_ca.sh
. 03-2_startup_orderer_ca.sh
wait 5
. 04-1-0_register_orderers.sh
. 04-1-1_prepare_for_orderers.sh
. 04-1-2_startup_orderers.sh
wait 10
docker-compose ps
. 05-1_create_channel.sh
. 06-1_install_chaincode_to_peer0.sh
. 06-2-1_setup_peer1.sh
. 06-2-2_install_chaincode_to_peer1
