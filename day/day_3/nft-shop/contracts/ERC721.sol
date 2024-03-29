// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyNFT is ERC721,AccessControl,ERC721Burnable
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC721("xx","xxx")
    {
        _grantRole(MINTER_ROLE,msg.sender);
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
    }

    function safeMint(address to,uint256 tokenId) public onlyRole(MINTER_ROLE) {
        _safeMint(to,tokenId);        
    }
    
    function supportsInterface(bytes4 interfaceId) public view override(ERC721,AccessControl) returns(bool)
    {
        return super.supportsInterface(interfaceId);
    }
}