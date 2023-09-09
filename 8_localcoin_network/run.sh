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
. 02-2-0_register_peer1-sdl.sh
. 02-2-1_prepare_for_peer1-sdl.sh
. 02-2-2_startup_peer1-sdl.sh
wait 5
. 03-1_generate_signed_certificates_for_orderer_ca.sh
. 03-2_startup_orderer_ca.sh
wait 5
. 04-1-0_register_orderers.sh
. 04-1-1_prepare_for_orderers.sh
. 04-1-2_startup_orderers.sh
wait 10
# docker-compose ps
# . 05-0_export_env_peer0.sh
# # . 05-0_export_env_peer1.sh
# . 05-1_create_channel.sh
# . 06-1_deploy_chaincode_odoo_user.sh
# # . 06-2_deploy_chaincode_erc721.sh
# # . 06-3_deploy_chaincode_erc20.sh
# . 06-4_deploy_chaincode_gtoken.sh
# . 06-5_deploy_chaincode_localcoin.sh
# successln "All done!"
# # read -p "CTRL+C to cancle"
