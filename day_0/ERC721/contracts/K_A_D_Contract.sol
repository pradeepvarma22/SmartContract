//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract K_A_D_Contract is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractOwner;

    constructor() ERC721("K_A_D", "KAD") {
        contractOwner=msg.sender;
    }


    modifier onlyOwner
    {
        require(msg.sender==contractOwner,"U dont have access");
        _;
    }

    function awardItem(address to, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }
}
