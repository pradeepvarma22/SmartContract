# Smart Contract

Smart Contract Verify Using Hardhat



#Steps
<ol>
    <li>yarn add nomiclabs/hardhat-etherscan</li>
<li>
<code>

import "@nomiclabs/hardhat-etherscan";
etherscan: {
	apiKey: process.env.ETHER_SCAN_API_KEY!
}
</code>
</li>
<li>
add arguments.ts 
</li>
<li>
yarn hardhat run scripts/deploy.ts --network goerli
</li>
<li>
yarn hardhat --network goerli verify 0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2 --constructor-args arguments.ts
</li>
</ol>

<br/>

```shell
yarn hardhat compile
yarn hardhat run scripts/deploy.ts --network goerli
yarn hardhat verify --constructor-args arguments.ts DEPLOYED_CONTRACT_ADDRESS
yarn hardhat --network goerli verify 0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2 --constructor-args arguments.ts
```
<br/>

# Working
```shell
C:\Users\Pradeepvarma_22\Pradeepvarma_22\SmartContract\smartcontract-verify>yarn hardhat run scripts/deploy.ts --network goerli
yarn run v1.22.19
Contract Address:  0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2
Done in 20.69s.

C:\Users\Pradeepvarma_22\Pradeepvarma_22\SmartContract\smartcontract-verify>yarn hardhat --network goerli verify 0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2 --constructor-args arguments.ts
Nothing to compile
No need to generate any newer typings.
Successfully submitted source code for contract
contracts/MyContract.sol:MyContract at 0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2
for verification on the block explorer. Waiting for verification result...

Successfully verified contract MyContract on Etherscan.
https://goerli.etherscan.io/address/0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2#code
Done in 13.92s.
```
<br/>

# Link
<a href="https://goerli.etherscan.io/address/0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2#code">https://goerli.etherscan.io/address/0xE7AaD05D9D365e32a76df717Df3902d184FD0AF2#code</a>