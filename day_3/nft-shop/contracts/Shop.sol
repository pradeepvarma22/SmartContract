// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Shop {

    uint256 public purchaseRatio;

    constructor(uint256 _purchaseRatio)
    {
        purchaseRatio=_purchaseRatio;
    } 

}