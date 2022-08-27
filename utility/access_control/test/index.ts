import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { MyContract } from "../typechain-types";
import { Contract } from "ethers";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers/dist/src/loadFixture";

describe("Access Control Contract", function () {
  let contract : Contract;
  let accounts: any[];


  async function deployContract() {
    const mycontractF = await ethers.getContractFactory("MyContract");
    contract = await mycontractF.deploy();
    await contract.deployed();
    accounts = await ethers.getSigners();
  }

  

  describe("After Deploy Check", async function () {

    it("Name Must be Empty", async function() {
      await loadFixture(deployContract);
      const _name = await contract.name();
      await expect(_name).to.equal("");    
    });

    it("Admin Role: Must Be HashZero and Should Accept only deployed Address", async function() {
      
      const zeroHash = await ethers.constants.HashZero;
      
      let adminrole = await contract.hasRole(zeroHash,accounts[0].address);

      await expect(adminrole).to.equals(true);
      
      adminrole = await contract.hasRole(zeroHash,accounts[1].address);

      await expect(adminrole).to.equals(false);

    });

  });


  describe("Contract TDD", async function() {
    
    
    it("setRole",async () => {

        let roleName = "PRADEEP";

        const setrole_f = await  contract.connect(accounts[0]).setRole(roleName, accounts[1].address );

        let roleNameBytes32 =await ethers.utils.solidityKeccak256(['string'], [roleName]);
        // roleNameBytes32 = await ethers.utils.keccak256(roleNameBytes32);
        let check  = await contract.hasRole(roleNameBytes32,accounts[1].address );
        //MUST PASS
        await expect(check).to.equals(true);
        //MUST FAIL
        roleName = "VARMA";
        roleNameBytes32 =await ethers.utils.solidityKeccak256(['string'], [roleName]);
        check  = await contract.hasRole(roleNameBytes32,accounts[1].address );
        await expect(check).to.equals(false);

    });

    it("setName", async function(){

      let  roleName= "PRADEEP";
      let   setname = await contract.connect(accounts[1]).setName("Pradeep Varma",roleName);
      let _name = await contract.name();
      await expect(_name).to.equal("Pradeep Varma");    

      
      setname = await contract.connect(accounts[0]);


      await expect(setname.setName("Ganesh",roleName)).to.revertedWith("only rolePerson should call");

      

    })



  });



});