const { expect } = require("chai");
const hre = require("hardhat");


describe("EventContract", function(){

    let contractFactory,contract,accounts;

  beforeEach(async function(){

    contractFactory =await  hre.ethers.getContractFactory("EventContract"); 

    contract = await contractFactory.deploy();

    await contract.deployed();

    accounts = await hre.ethers.getSigners();

  });


  describe("Name Events Check", function(){


    it("setName",async function(){

      await expect(contract.setName("Pradeep varma")).to.emit(contract,"SetNameEvent").withArgs(accounts[0].address,"Pradeep varma");

    });

    it("getName",async function(){

      await expect(contract.getName()).to.emit(contract,"GetNameEvent").withArgs(accounts[0].address,"");

    });


  });


  describe("URI Events Check", function(){


    it("SetURIEvent",async function(){

      await expect(contract.setURI("pradeepvarma22.github.io")).to.emit(contract,"SetURIEvent").withArgs(accounts[0].address,"pradeepvarma22.github.io");

    });

    it("GetURIEvent",async function(){

      await expect(contract.getURI()).to.emit(contract,"GetURIEvent").withArgs(accounts[0].address,""); 

    });


  });




});