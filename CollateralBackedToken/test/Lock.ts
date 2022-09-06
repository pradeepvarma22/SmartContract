import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { loadFixture, time } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { BigNumber } from "ethers";
import { ethers } from "hardhat";

import CollateralBackedToken from "../typechain-types/contracts/CollateralBackedToken.ts";
import MyToken from "../typechain-types/contracts/MyToken.ts";

describe("CollateralBackedToken", function () {
  let anyTokenContract: MyToken;
  let CBTContract: CollateralBackedToken;
  let accounts: any[];

  async function deploy() {

    accounts = await ethers.getSigners();
    const contract1F = await ethers.getContractFactory("MyToken");
    anyTokenContract = await contract1F.deploy();
    await anyTokenContract.deployed();

    const contract2F = await ethers.getContractFactory("CollateralBackedToken");
    CBTContract = await contract2F.deploy(anyTokenContract.address);
    await CBTContract.deployed();
  }

  describe("After Deployment", async function () {

    it("It Should Deploy and Check Initial Balances", async function () {

      await loadFixture(deploy);
      const balance: BigNumber = await anyTokenContract.balanceOf(accounts[0].address);        // returns BigNumber
      const _100Tokens: BigNumber = BigNumber.from("100000000000000000000");
      expect(balance).to.equal(_100Tokens);      // 100 tokens            // BigNumber.from converts String to BigNumber

    })

    it("It Should Approve and check Approve balances", async function () {
      const _100Tokens: BigNumber = BigNumber.from("100000000000000000000");
      await anyTokenContract.approve(CBTContract.address, _100Tokens);
      const allowance: BigNumber = await anyTokenContract.allowance(accounts[0].address, CBTContract.address);
      expect(allowance).to.equal(_100Tokens);
    })

    it("deposit anyTokenBalance to CBT Contract and check both balances", async function () {
      const _100Tokens: BigNumber = BigNumber.from("100000000000000000000");
      await CBTContract.deposit(_100Tokens)
      const multiplier: BigNumber = _100Tokens.mul(2);

      const balance = await CBTContract.balanceOf(accounts[0].address);
      expect(balance).to.equal(multiplier);
    })

    it("It Should Withdraw token balance to anyTokenContract", async function () {
      const _100Tokens: BigNumber = BigNumber.from("100000000000000000000");
      const multiplier: BigNumber = _100Tokens.mul(2);
      await CBTContract.withdraw(multiplier)

      const balance = await CBTContract.balanceOf(accounts[0].address);
      expect(balance).to.equal(0);

      const balance_2: BigNumber = await anyTokenContract.balanceOf(accounts[0].address);        // returns BigNumber

      expect(balance_2).to.equal(_100Tokens);

    })

  })


});

