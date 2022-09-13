//4 Investor will invest liquidity and get governancec token
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./UnderlyingToken.sol";
import "./LpToken.sol";
import "./GovernanceToken.sol";

contract LiquidityPool is LpToken {

    mapping(address => uint256) public checkpoints;
    UnderlyingToken public underlyingtoken;
    GovernanceToken public governancetoken;
    uint constant public REWARD_PER_BLOCK=1;                    // investor will earn 1 governance token per block or for each underlying  token that they invest

    constructor(address _underlyingtoken, address _governancetoken)
    {
        underlyingtoken = UnderlyingToken(_underlyingtoken);
        governancetoken = GovernanceToken(_governancetoken);
    }

    // investor can provide liquidity
    function deposit(uint256 amount) external {

        if(checkpoints[msg.sender]==0)
        {
            checkpoints[msg.sender] = block.number;                    // check points are used as reference  to distribute governance token rewards
        }
        
        _distributeRewards(msg.sender);
        underlyingtoken.transferFrom(msg.sender, address(this), amount);            // before it should approve

    }


    function withdraw(uint256 amount) external {

        require(balanceOf(msg.sender) >= amount, "Not Enough LP Token");
        _distributeRewards(msg.sender);
        underlyingtoken.transfer(msg.sender,amount);
        _burn(msg.sender, amount);

    }



    function _distributeRewards(address beneficiary) internal {
        uint256 checkpoint = checkpoints[beneficiary];

        if(block.number - checkpoint > 0)                   // if block number is already same i.e same blocknumber it will give zero it means that already distributed or its the first time 
        {
            uint256 distributionamount = balanceOf(beneficiary)   * (block.number - checkpoint) * REWARD_PER_BLOCK;                // lp token Contract
            // if i invested 10lp tokens if the block after is 15 then it will be 10 * 15 * 1 = 150 governance token    
            governancetoken.mint(beneficiary, distributionamount);
            checkpoints[beneficiary] = block.timestamp;
        }
         
    }

}   
