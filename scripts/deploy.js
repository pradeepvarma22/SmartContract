const hre = require("hardhat");

async function main() {
    const EventContractFactory = await hre.ethers.getContractFactory("EventContract");

    const EventContract = await EventContractFactory.deploy();

    await EventContract.deployed();

    console.log(EventContract.address);






    //lisiting events will not stop until we stop the process 
    EventContract.on("GetNameEvent",(whoasked, name, event)=>{
        console.log("GetNameEvent--->");
        console.log(whoasked);
        console.log(name);
    });

    EventContract.on("SetNameEvent",(whoasked, name, event)=>{
      console.log("SetNameEvent--->");
      console.log(whoasked);
      console.log(name);
    });


    

    await EventContract.getName();
    await EventContract.setName("Pradeep varma");
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

