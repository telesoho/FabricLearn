"use strict";

const { Contract } = require("fabric-contract-api");

class OdooUserContract extends Contract {
    async ClientAccountID(ctx) {
        const clientAccountID = ctx.clientIdentity.getID();
        return clientAccountID;
    }

    async ClientAccountInfo(ctx) {
        return {
            id: ctx.clientIdentity.getID(),
            role: ctx.clientIdentity.getAttributeValue("role")
        };
    }
}

module.exports = OdooUserContract;
