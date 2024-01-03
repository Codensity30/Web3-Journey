import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const rpc = process.env.RPC_URL;
const privateKey = process.env.SEPOLIA_PRIVATE_KEY;
const etherscanAPI = process.env.ETHERSCAN_API_KEY;
if (!privateKey) {
  throw new Error("Enviroment Variables missing");
}

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    sepolia: {
      url: rpc,
      accounts: [privateKey],
      chainId: 11155111,
    },
  },
  etherscan: {
    apiKey: etherscanAPI,
  },
};

export default config;
