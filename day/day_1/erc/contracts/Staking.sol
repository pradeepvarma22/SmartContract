// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking 
{
    // whitelisted address that can deposit and withdraw in this contract
    mapping(bytes32 => address) public _whileListedTokens;       // key: whitelistedTokens value: tokenAddress
    mapping(address => mapping(bytes32 => uint256)) public _accountBalances; // walletAddress, Symbol, amount of token deposisted
    address private _owner;                         // who can whitelist tokens

    constructor()
    {
        _owner = msg.sender;
    }

    function whiteListTokens(bytes32 symbol, address token) external{
        
        require(_owner == msg.sender,"You dont have access");
        _whileListedTokens[symbol]=token;
        
    }

    function depositTokens(uint256 amount,bytes32 symbol)external {

        //increment account balances
        _accountBalances[msg.sender][symbol] += amount;
        
        //
        IERC20(_whileListedTokens[symbol]).transferFrom(msg.sender, address(this), amount);
        
    }

    function withdrawTokens(uint256 amount,bytes32 symbol)external {

        //increment account balances
        _accountBalances[msg.sender][symbol] -= amount;
        
        //
        IERC20(_whileListedTokens[symbol]).transfer(msg.sender, amount);
        
    }


}