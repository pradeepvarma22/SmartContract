//3
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UnderlyingToken is ERC20 {

    constructor() ERC20("Lp Token","LTK")
    {
        
    }

    //only for development purpose
    function faucet(address to, uint amount) external{
        _mint(to, amount);
        
    }

}
