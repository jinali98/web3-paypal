require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ignition");
// require("@nomiclabs/hardhat-etherscan");
const dotenv = require("dotenv");

dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    amoy: {
      url: process.env.INFURA_URL, // Replace with the correct URL for Amoy
      accounts: [process.env.PRIVATE_KEY], // Ensure your private key is stored in an environment variable
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY, // Optional: If Amoy supports contract verification similar to Etherscan
  },
};
