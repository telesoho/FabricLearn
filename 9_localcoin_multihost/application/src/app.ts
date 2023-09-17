// import * as FabricCAServices from 'fabric-ca-client';
import * as path from 'path';
import * as Constants from './constants';
import * as Gateway from "./lib/gateway";
import * as BaseUtils from "./lib/utility/baseUtils";
import {CommonConnectionProfileHelper} from './lib/utility/commonConnectionProfileHelper';


async function main() {
    try {
        const gatewayName = "localcoinGateway";
        const ccpName = "localcoin-ccp.json";
        const useDiscovery = true;
        const tls = false;
        const userName = "sdl-admin";
        const orgName= "sdl";
        const walletType = Constants.MEMORY_WALLET;

        BaseUtils.logMsg(`Creating new Gateway named ${gatewayName}`);
        const profilePath: string = path.join(Constants.CONFIG_PATH, ccpName);
        const ccp: CommonConnectionProfileHelper = new CommonConnectionProfileHelper(profilePath, true);
        const gateway = await Gateway.createGateway(ccp, tls, userName, orgName, gatewayName, useDiscovery, walletType);
        return gateway;
    } catch (error) {
        console.error(`******** FAILED to run the application: ${error}`);
        process.exit(1);
    }
}

main();
