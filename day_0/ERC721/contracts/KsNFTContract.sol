//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./ERC721.sol";

contract KsNftContract is ERC721
{
    string public name;         //ERC721Metadata
    string public symbol;       //ERC721Metadata
    uint256 public tokenCount;
    mapping(uint256 => string) private tokenURIs; 

    constructor(string memory _name, string memory _symbol)
    {
        name = _name;
        symbol = _symbol;
    }

    // tokenURI where we store metadata
    // returns url that points meta data
    function tokenURI(uint256 _tokenId) public view returns(string memory)          //ERC721Metadata
    {
        require(owners[_tokenId] != address(0), "TokenId does not exit");
        return tokenURIs[_tokenId];
    }
    // mint: creates new nft inside 
    function mint(string memory _tokenURI) public 
    {
        tokenCount+=1 ; //tokenId
        balances[msg.sender] +=1;
        owners[tokenCount] = msg.sender;
        tokenURIs[tokenCount] =_tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    // let opensea know what functions inside of our smartcontract we added ERC721Metadata
    function supportsInterface(bytes4 interfaceId) public pure override returns(bool)
    {
        return interfaceId == 0x80ac58cd || interfaceId ==   0x5b5e139f; 
    }


}