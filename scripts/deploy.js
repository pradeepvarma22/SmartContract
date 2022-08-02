const hre = require("hardhat");

async function main() {
    const EventContractFactory = await hre.ethers.getContractFactory("EventContract");

    const EventContract = await EventContractFactory.deploy();

    await EventContract.deployed();

    console.log(EventContract.address);

    EventContract.on("GetNameEvent",(whoasked, name, event)=>{
        console.log("GetNameEvent--->");
        console.log(whoasked);
        console.log(name);
    });

    await EventContract.getName();

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
