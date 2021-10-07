import { Contract } from "ethers";
const hre = require("hardhat");

const network = hre.network.name;
const fs = require('fs');
const dotenv = require('dotenv');
const envConfig = dotenv.parse(fs.readFileSync(`.env`))

for (const k in envConfig) {
    process.env[k] = envConfig[k]
}

async function main() {
    const accounts = await hre.ethers.getSigners();
    const sender = accounts[0].address;
    console.log("Sender address: ", sender);

    const Token = await hre.ethers.getContractFactory("Token");
    let token = await Token.deploy();

    console.log(`Smart contract has been deployed to: ${token.address}`);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });