/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require('@nomiclabs/hardhat-waffle');
require('dotenv').config();
var HDWalletProvider = require("truffle-hdwallet-provider");

//посмотреть локальные переменные prientenv
module.exports = {
  solidity: "0.8.0",
  networks: {
    // rinkeby: {
    //   url: process.env.INFURA_URL,
    //   accounts: [`0x${process.env.PRIVATE_KEY}`],
    // }
    rinkeby: {
      url: process.env.INFURA_API_KEY,
      accounts: {mnemonic: process.env.MNEMONIC},
    }
  },
};
