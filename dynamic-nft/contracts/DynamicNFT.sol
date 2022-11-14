// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract DynamicNFT is ERC721, ERC721URIStorage, AutomationCompatibleInterface {
    uint256 tokenCounter;
    uint256 lastTimeStamp;
    uint256 interval;

    string[] IpfsTokenURI = [
        "https://ipfs.io/ipfs/bafybeidupdgc3varauhc7b5cnnnjcugtztxwk5r3hq7h27vogevvwyknva/1.json",
        "https://ipfs.io/ipfs/bafybeig4dttcozuyottn63sioadxdaepifi4nuunppzbuntlzggmwlfwk4/2.json",
        "https://ipfs.io/ipfs/bafybeidlevm235ylpfrx4qiweri6kmv56y5zeyk5p7o2xjaq7krdylbxku/3.json",
        "https://ipfs.io/ipfs/bafybeigt52gp5nvs2lwgwjo2erkroyistubyu3jc5fckxxmr4ycgjg5gra/4.json"
    ];

    constructor() ERC721("DNFT NAME", "DNFT") {
        tokenCounter = 0;
        interval = 60 seconds;
        lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(bytes calldata)
        external
        view
        override
        returns (
            bool upkeepNeeded,
            bytes memory /* performData */
        )
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        // We don't use the checkData in this example. The checkData is defined when the Upkeep was registered.
    }

    function performUpkeep(bytes calldata) external override {
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;

            growMachine(1);
        }
    }

    function safeMint(address to) external {
        tokenCounter += 1;
        uint256 tokenId = tokenCounter;
        _safeMint(to, tokenCounter);
        _setTokenURI(tokenId, IpfsTokenURI[0]);
    }

    function growMachine(uint256 _tokenId) public {
        if (machineStage(_tokenId) >= IpfsTokenURI.length) {
            return;
        }

        uint256 tokenIndex = machineStage(_tokenId) + 1;

        string memory newURI = IpfsTokenURI[tokenIndex];
        _setTokenURI(_tokenId, newURI);
    }

    function machineStage(uint256 _tokenId)
        public
        view
        returns (uint256 _bool)
    {
        string memory _uri = tokenURI(_tokenId);
        for (uint256 index = 0; index < IpfsTokenURI.length; index += 1) {
            bytes32 temp = keccak256(abi.encodePacked(IpfsTokenURI[index]));
            bytes32 temp_2 = keccak256(abi.encodePacked(_uri));
            if (temp == temp_2) {
                _bool = index;
            }
        }
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
