// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract TimeStamp {
    uint256 public unlockTime;

    constructor() payable {
        unlockTime = block.timestamp;
    }

    function getTimeStamp() public view returns (uint256) {
        return unlockTime;
    }
}
