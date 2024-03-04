require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

const { SEPOLIA_PRIVATE_KEY, ALCHEMY_API_KEY } = process.env;

module.exports = {
  solidity: "0.8.0",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`, 
      accounts: [`0x${SEPOLIA_PRIVATE_KEY}`],
    },
  },
};
