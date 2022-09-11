// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CollateralBackedToken is ERC20 {
    IERC20 public obj;
    uint256 private multipler;

    constructor(address erc20Addr) ERC20("CollateralBackedToken", "CBT") {
        obj = IERC20(erc20Addr);
        multipler = 2;
    }

    // first other contract token must approve this address
    function deposit(uint256 myTokenAmount) external {
        obj.transferFrom(msg.sender, address(this), myTokenAmount);

        _mint(msg.sender, multipler * myTokenAmount);
    }

    function withdraw(uint256 cbtTokenAmount) external {
        require(
            balanceOf(msg.sender) >= cbtTokenAmount,
            "insufficient balance"
        );
        _burn(msg.sender, cbtTokenAmount);
        obj.transfer(msg.sender, cbtTokenAmount / multipler);
    }
}
