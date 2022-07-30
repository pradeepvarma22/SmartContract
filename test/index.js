const { expect } = require("chai");
const { ethers } = require("hardhat");

function convertStringToBytes32(arr){

    const bytes32Array = [];

    for(let i=0;i<arr.length;i++)
    {
        bytes32Array.push(ethers.utils.formatBytes32String(arr[i]));
    }
    
    return bytes32Array;
}

const PROPOSALS = ["Pradeep", "Pramod", "Ganesh"]

describe("Ballot SmartContract",function(){

    let ballotContract,ballotContractDeploy,accounts;
    let count =0;
    beforeEach(async function () {
        accounts = await ethers.getSigners();
        ballotContract = await ethers.getContractFactory("BallotContract");
        ballotContractDeploy = await ballotContract.deploy(convertStringToBytes32(PROPOSALS));
        await ballotContractDeploy.deployed();

    });

    describe("When Contract is deployed", function(){

        it("sets the deployer address as chairperson", async function(){

            const chairPerson = await ballotContractDeploy.admin();

             expect(chairPerson).to.equal(accounts[0].address);

        });

        it("Check Vote Count for all must be 0", async function(){
            

            for(let i=0;i<3;i++)
            {
                const obj = await ballotContractDeploy.proposals(i);
                expect(obj.voteCount).to.equal(0);
            }

        });

        it("Check Proposals Name", async function(){
            

            for(let i=0;i<3;i++)
            {
                const obj = await ballotContractDeploy.proposals(i);
                expect(ethers.utils.parseBytes32String(obj.name)).to.equal(PROPOSALS[i]);
            }

        });


    });


    describe("Interacting with giveAcessToVote function",function(){

        

        it("Checking any one can access without deploying", async function(){

            const obj = await ballotContractDeploy.connect(accounts[1]);

            await expect(obj.giveAcessToVote(accounts[3].address)).to.be.revertedWith('you dont have access');

            // console.log(obj);
        });

        it("admin giving access to account 1", async function(){

            const obj = await ballotContractDeploy.connect(accounts[0]);
            await obj.giveAcessToVote(accounts[1].address);
            const obj1 = await ballotContractDeploy.voters(accounts[1].address);
            expect(obj1.weight).to.equal(1);
        });
    });

});

describe("Vote Function Check", function(){

    let ballotContract,ballotContractDeploy,accounts;

    before(async function(){
        ballotContract = await ethers.getContractFactory("BallotContract");
        ballotContractDeploy = await ballotContract.deploy(convertStringToBytes32(PROPOSALS));

        await ballotContractDeploy.deployed();

        accounts = await ethers.getSigners();

    });


    it("check how many has voted before doing voting answer must be zero", async function(){
        for(let i=0;i<4;i++)
        {
            const ans = await ballotContractDeploy.voters(accounts[i].address);
            expect(ans.isVoted).to.equal(false);
        }
        
    });

    it("as a admin giving access to first 3 addresses ", async function(){
        await ballotContractDeploy.connect(accounts[0].address);
        for(let i=1;i<=3;i++)
        {
            await ballotContractDeploy.giveAcessToVote(accounts[i].address);
        }
        let count =0;
        for(let i=1;i<=6;i++)
        {
            const obj = await ballotContractDeploy.voters(accounts[i].address);
            count += Number(obj.weight);
        }
        expect(count).to.equal(3);

    });


    it("Vote function",async function(){

        await ballotContractDeploy.vote(0);
        let obj = await ballotContractDeploy.voters(accounts[0].address);
        expect(await obj.isVoted).to.equal(true);

        
        await expect(ballotContractDeploy.connect(accounts[1].address).vote(1))

        let obj2 = await ballotContractDeploy.voters(accounts[1].address);
        expect(await obj2.isVoted).to.equal(true);

        
        
        // await ballotContractDeploy.vote(1);
        // obj = await ballotContractDeploy.voters(accounts[1].address);
        // expect(await obj.isVoted).to.equal(true);
        // console.log('2');

        // await ballotContractDeploy.connect(accounts[2].address);
        // await ballotContractDeploy.vote(2);
        // obj = await ballotContractDeploy.voters(accounts[2].address);
        // expect(await obj.isVoted).to.equal(true);
        // console.log('3');

        // await ballotContractDeploy.connect(accounts[3].address);
        // await ballotContractDeploy.vote(2);
        // obj = await ballotContractDeploy.voters(accounts[3].address);
        // expect(await obj.isVoted).to.equal(true);
        // console.log('4');

        // await ballotContractDeploy.connect(accounts[4].address);
        // expect(await ballotContractDeploy.vote(2)).to.be.revertedWith("please get access");



    });



});