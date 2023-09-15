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

    async Test(ctx, name = "odoo-user", symbol = "Odoo User") {
        await ctx.stub.putState("nameKey", Buffer.from(name));
        await ctx.stub.putState("symbolKey", Buffer.from(symbol));
        return true;
    }

}

module.exports = OdooUserContract;
