// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyContract is AccessControl
{

    string public name;


    constructor()
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function setRole(string memory _roleName, address _roleAddress) external onlyRole(DEFAULT_ADMIN_ROLE) returns(string memory)  {
        // require(hasRole(MY_ROLE, msg.sender));
        bytes32 roleName = keccak256(abi.encodePacked(_roleName));
        _grantRole(roleName, _roleAddress);
        return _roleName;
    }


    function setName(string memory _name,string memory _roleName) external returns(bool)
    {
        bytes32 roleName = keccak256(abi.encodePacked(_roleName));
        require(hasRole(roleName, msg.sender),"only rolePerson should call");
        name = _name;
        return true;
    }





}
