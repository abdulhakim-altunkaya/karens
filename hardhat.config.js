require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ignition");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    bnb: {
      url: process.env.PROVIDER_URL,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    fantom: {
      url: process.env.PROVIDER_URL_2,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    polygon: {
      url: process.env.PROVIDER_URL_3,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    fantomtest: {
      url: process.env.PROVIDER_URL_4,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    bnbtest: {
      url: process.env.PROVIDER_URL_5,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  }
};



