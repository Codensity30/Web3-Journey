import { ethers, run, network } from "hardhat";

async function main() {
  // deploying contract
  const contract = await ethers.deployContract("SimpleStorage");
  await contract.waitForDeployment();
  console.log("Deployed! Contract Address - ", contract.target);

  // verifying contract if it's deployed on sepolia testnet
  if (network.config.chainId === 11155111) {
    const adr = await contract.getAddress();
    await verify(adr, []);
  }

  // interacting with contract
  let favNum = await contract.favNum();
  console.log("Favorite Number = ", String(favNum));
  await contract.setFavNum(3);
  favNum = await contract.favNum();
  console.log("Updated favNum = ", String(favNum));
}

async function verify(contractAddress: string, args: []) {
  console.log("Verifying Contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (error) {
    console.log(error);
  }
}

main().catch((e) => {
  console.log(e);
  process.exit(1);
});
