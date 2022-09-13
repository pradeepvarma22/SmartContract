// Liquidity provider token: once liquiuty get into this will be exchanged
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract LpToken is ERC20 {


    constructor() ERC20("Lp Token","LTK")
    {
    }

}
