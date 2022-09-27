import { ethers } from "hardhat";

async function main() {

	const contractFactory = await ethers.getContractFactory("MyContract");
	const owner_address = "0x6B4c696B623FA9A2A6D5b6E9101Ef19CD973bc3C";
	
	const bytes32Role = ethers.utils.formatBytes32String("test");
	
	const pradeepObj = {
		id: 10,
		age: 23
	};
	
	const contract = await contractFactory.deploy(owner_address, bytes32Role, pradeepObj);
	await contract.deployed();
	
	console.log(bytes32Role);
	console.log("Contract Address: ",contract.address);
	
	
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
