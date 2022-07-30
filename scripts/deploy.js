const hre = require("hardhat");
const ethers = require("ethers");

require('dotenv').config();

import * as BallotJson from '../artifacts/contracts/Ballot.sol/BallotContract.json';


async function main() {

  console.log('Deploy...............');









}





main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
