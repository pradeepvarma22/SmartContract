import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config()

const private_key: any = process.env.PRIVATE_KEY;

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks:{
    mumbai:{
      url: process.env.MUMBAI_URL,
      accounts: [ private_key ]
    }
  }
};

export default config;
