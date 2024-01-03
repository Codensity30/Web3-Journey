import { ethers } from "ethers";
import { readFileSync } from "fs";
require("dotenv").config();

async function main() {
  try {
    if (!process.env.RPC_URL || !process.env.PRIVATE_KEY) {
      throw new Error("Enviroment Variables missing");
    }
    const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    const abi = readFileSync("./bin/contracts/SimpleStorage.abi", "utf-8");
    const byteCode = readFileSync("./bin/contracts/SimpleStorage.bin", "utf-8");

    // creating a contract factory to deploy contracts
    const contractFactory = new ethers.ContractFactory(abi, byteCode, wallet);

    // deploying contract
    console.log("Deploying contract...");
    const contract = await contractFactory.deploy();
    await contract.waitForDeployment();
    const contractAdr = await contract.getAddress();
    console.log(`Contract deployed to ${contractAdr}`);

    let favNum = await contract.getFunction("favNum").call(null);
    console.log(String(favNum));
    await contract.getFunction("setFavNum").call(null, 3);
    favNum = await contract.getFunction("favNum").call(null);
    console.log(String(favNum));
  } catch (error) {
    console.error(error);
  }
}

// running the async main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
