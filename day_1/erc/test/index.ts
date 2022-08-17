import { expect } from "chai";
import { ethers } from "hardhat";

describe("Staking", function () {
	
  let owner: any;
  let wallet1: any;
  let wallet2: any;

  let StakingFactory: any;
  let Staking: any;

  let TokenContractFactory: any;
  let token: any;
  let tokenInBytes:any;

    beforeEach(async function () {
      [ owner, wallet1, wallet2] = await ethers.getSigners();

      StakingFactory = await ethers.getContractFactory('Staking', owner);
      TokenContractFactory = await ethers.getContractFactory('VarmaToken', wallet1);

      Staking = await StakingFactory.deploy();

      token =await TokenContractFactory.deploy("VARMA","PK");

      await token.connect(wallet1).transfer(wallet2.address, 1000);

      //preapprove staking contract to deposit from wallet1 and wallet2
      
      await token.connect(wallet1).approve(Staking.address, 4000);
      await token.connect(wallet2).approve(Staking.address, 1000);

      tokenInBytes = ethers.utils.formatBytes32String("PK");
      await Staking.connect(owner).whiteListTokens(tokenInBytes,token.address);
    });



    describe("deployment", async function() {

      it("it should mint tokens to wallet1", async function() {
          expect(await token.balanceOf(wallet1.address)).to.equal(4000);
      });

      it("it should mint tokens to wallet2", async function() {
        
        expect(await token.balanceOf(wallet2.address)).to.equal(1000);

      });


      it("should whitelist erctoken on the contract", async function() {
        expect(await Staking._whileListedTokens(tokenInBytes)).to.equal(token.address);
      });
      
    });


    describe("deposit Tokens", async function() {

      it("should deposit erctokens", async function() {

        
      });
      
    });

    
    describe("withdraw Tokens", async function() {

      it("should withdraw erctokens from the contract", async function() {


        
      });
      
    });
    



});