import { ethers } from "hardhat";

async function main() {

  const KsNFTContractFactory: any = await ethers.getContractFactory("KsNftContract");
  const KsNFTContract: any = await KsNFTContractFactory.deploy("K_A_D_CLICKS","KADC");
  await KsNFTContract.deployed();
  console.log("Contract was deployed to :",KsNFTContract.address);

  const mint_nft:any =  await KsNFTContract.mint("https://ipfs.io/ipfs/bafybeicps6jiqliutufhcm54fbwem6fy4ovfnf6kjqgq4ktjy23qq6txpm/image.json");
  const mintNFT = await mint_nft.wait();
  console.log('Minted',mintNFT)
  
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
