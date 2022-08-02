const ethers = require("ethers");
const EventContractJson=  require('../artifacts/contracts/EventContract.sol/EventContract.json');
require("dotenv").config();



function setListingEvent( contract, provider ){

    const eventFilter1 = contract.filters.GetNameEvent();

    provider.on(eventFilter1, (log)=>{
        console.log("GetNameEvent");
        console.log({log});
    });

    const eventFilter2 = contract.filters.SetNameEvent();
    provider.on(eventFilter2, (log)=>{
        console.log("SetNameEvent");
        console.log({log});
    });

    const eventFilter3 = contract.filters.GetURIEvent();
    provider.on(eventFilter3, (log)=>{
        console.log("GetURIEvent");
        console.log({log});
    });


    const eventFilter4 = contract.filters.SetURIEvent();
    provider.on(eventFilter4, (log)=>{
        console.log("SetURIEvent");
        console.log({log});
    });
    
}

function getProvider()
{
    const provider =new ethers.providers.JsonRpcProvider(process.env.ALCHEMY_API_KEY);
    return provider;
}

function getSigner(provider)
{
    const signer =new ethers.Wallet(process.env.PRIVATE_KEY, provider);
    return signer;
}



async function getContract(provider,signer)
{
    signer = signer.connect(provider);                              //change wallet to signin using provider
    const eventContractFactory = new ethers.ContractFactory(
        EventContractJson.abi,
        EventContractJson.bytecode,
        signer
    );

    const eventContract = await eventContractFactory.deploy();

    await eventContract.deployed();

    console.log(eventContract.address);


    return eventContract;
}

async function testMe(contract)
{
    await contract.setName("Pradeep varma 2292");
    await contract.getName();
    await contract.setURI("pradeepvarma22.github.io");
    await contract.getURI();

}

async function testMe(contract){
    await contract.setName("Pradeep Varma");
    await contract.getName();
    await contract.setURI("pradeepvarma22.github.io");
    await contract.getURI();
}



async function main(){
    const provider = getProvider();
    const signer = getSigner();
    const contract =await getContract(provider,signer);
    setListingEvent(contract,provider);
    console.log('====================>',contract.address);
    console.log('Events: ');
    testMe(contract);


}

main();







/*

    if we keep it in global without using any functions contract will return promise
    so we have used async main method to get out of it and again we waited for it to complete



    const provider = getProvider();
    const signer = getSigner();
    const contract = getContract(provider,signer);



    const contract =await getContract(provider,signer);















------------------------------------------------------------------------------------------




Error: replacement fee too low [ See: https://links.ethers.org/v5-errors-REPLACEMENT_UNDERPRICED ] (error={"reason":"processing response error","code":"SERVER_ERROR","body":

The error means that:

You have a pending transaction from your account in your Ethereum client
The new transaction you are sending has the same nonce as that pending transaction
The new transaction you sent has a gas price that is too small to replace the pending transaction


---------------------------------------------------------------------------------------------

if we keep one event two times it wont work it will be in loop
ex:  if we keep two at a time it wont work as expected




    //another way
    contract.on("GetNameEvent",(whoasked, name, event)=>{
        console.log("GetNameEvent-- Another Way ->");
        console.log(whoasked);
        console.log(name);
    });




    const eventFilter1 = contract.filters.GetNameEvent();

    provider.on(eventFilter1, (log)=>{
        console.log("GetNameEvent");
        console.log({log});
    });


*/