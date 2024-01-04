import { ethers } from "hardhat";
import { expect } from "chai";
import { SimpleStorage } from "../typechain-types";

describe("Simple Storage", () => {
  let contract: SimpleStorage;
  beforeEach(async () => {
    contract = await ethers.deployContract("SimpleStorage");
  });

  it("Inital value of favNum is 0", async () => {
    const expectedValue = 0;
    const actualValue = await contract.favNum();
    expect(actualValue).to.equal(expectedValue);
  });

  it("FavNum should be updated when set", async () => {
    const expectedValue = "3";
    await contract.setFavNum(3);
    const actualValue = await contract.favNum();
    expect(actualValue).to.equal(expectedValue);
  });
});
