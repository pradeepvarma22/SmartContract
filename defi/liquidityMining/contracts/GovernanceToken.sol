//1 GovernanceToken which is given as a reward
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GovernanceToken is Ownable, ERC20 {
    constructor() ERC20("Governance token reward", "GTK") Ownable() {}

    function mint(address to, uint256 amount) external onlyOwner() {
        _mint(to, amount);
    }
}
