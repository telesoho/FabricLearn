pushd .
cd ..
. 00_setup_env.sh
. 01-1_startup_tls_ca.sh
wait 8
. 01-2_generate_signed_certificates_for_orgs_ca.sh
. 01-3_startup_org_ca.sh
popd 2>&1 1>&null