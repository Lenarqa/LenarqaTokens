// const { ethers } = require('hardhat');

// async function main() {
//     const [deployer] = await ethers.getSigners();
//     console.log(`Deploy contract with adress ${deployer.address}`);

//     const balance = await deployer.getBalance();
//     console.log(`Account balance = ${balance}`);

//     const Token = ethers.getContractFactory('Token');
//     const token = await Token.deploy();
//     console.log(`Token adress = ${token.address}`);
// }  

const hre = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deploy contract with adress ${deployer.address}`);

    const balance = await deployer.getBalance();
    console.log(`Account balance = ${balance}`);
    
    const Token = await hre.ethers.getContractFactory("Token");
    const token = await Token.deploy();
    console.log(`Token adress = ${token.address}`);
}

main()
    .then(() => process.exit(0)) //send 0 if all good
    .catch(error => {
        console.error(error);
        process.exit(1);//send 1 if no good
    })