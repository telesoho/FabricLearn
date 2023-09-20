. 00_setup_env.sh
. 01-1_startup_tls_ca.sh
wait 8
. 01-2_generate_signed_certificates_for_orgs_ca.sh
. 01-3_startup_org_ca.sh
wait 8
. 03-1_generate_signed_certificates_for_orderer_ca.sh
. 03-2_startup_orderer_ca.sh
wait 8
. 10_register_orderers.sh
docker-compose up -d files.localcoin.jp
wait 3
