import { ethers } from "hardhat";

async function main() {

  const KadNFTContractFactory: any = await ethers.getContractFactory("K_A_D_Contract");
  const KadNFTContract: any = await KadNFTContractFactory.deploy();
  await KadNFTContract.deployed();
  console.log("Contract was deployed to :",KadNFTContract.address);

const to_address: string="0xab5694775b36b4cC86E5288f4a6A906C82C8EF1C";
  const mint_nft:any =  await KadNFTContract.awardItem(to_address,"https://ipfs.io/ipfs/bafybeidfuhuuwxs6k7mrl6fgml3o3oippcknjfueztcmm4rni5cac43rm4/image_advanced.json");
  const mintNFT = await mint_nft.wait();
  console.log('Minted',mintNFT)
  
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
