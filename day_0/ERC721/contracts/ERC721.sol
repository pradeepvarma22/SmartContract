//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ERC721Interface{
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

contract ERC721 is ERC721Interface
{
        mapping(address => uint256) internal balances;

        mapping(uint256 => address) internal owners;

        //owner of nft, operator, isOperatorOrNot
        mapping(address => mapping(address => bool)) private operatorApprovals;
        
        mapping(uint256 => address) private tokenApprovals;

        // No of NFT'S Assigned to owner
        function balanceOf(address _owner)public override view returns (uint256)
        {
            require(_owner != address(0), "input address is zero address");
            return balances[_owner];
        }

        // Finds the owner of an NFT
        function ownerOf(uint256 _tokenId) public override view returns (address)
        {
            require(owners[_tokenId] != address(0), "TokenId does not exist");
            return owners[_tokenId];
        }

        // Operator Functions [opensea]: setApprovalForAll, isApprovedForAll
        // enables or disables an operator to manage all of msg.sender assests
        // multiple operators per owner
        function setApprovalForAll(address _operator, bool _approved) public override
        {
            operatorApprovals[msg.sender][_operator] = _approved;
            emit ApprovalForAll(msg.sender, _operator,_approved);
        }

        // if an address is an authorized operator for another address
        function isApprovedForAll(address _owner, address _operator) public override view returns (bool)
        {
            return operatorApprovals[_owner][_operator];
        }


        // Updates an approved address for an NFT
        // _approved is also called as to
        // approvals not same as operatorapprovals
        function approve(address _approved, uint256 _tokenId) public override payable
        {
            address _owner = ownerOf(_tokenId);
            require(_owner==msg.sender || isApprovedForAll(_owner,msg.sender), "only Owner of nft person should call || msg.sender not an operator");   //both conditions should be in samre require statement
            tokenApprovals[_tokenId] = _approved;
            emit Approval(_owner, _approved, _tokenId);
        }

        function getApproved(uint256 _tokenId) public view returns (address)
        {
            require(ownerOf(_tokenId) != address(0), "TokenId does not exit");
            return tokenApprovals[_tokenId];
        }

        // Transfers ownership of an NFT
        function transferFrom(address _from, address _to, uint256 _tokenId) public override payable
        {
            address _owner = ownerOf(_tokenId);

            require(
            msg.sender == _owner ||
            isApprovedForAll(_owner,msg.sender) ||
            getApproved(_tokenId) == msg.sender
            , "only Owner of nft person should call || msg.sender not an operator || not the approved for transfer getApproved ");

            require(_owner != address(0));
            require(_from ==_owner ,"from address is the owner" );
            require(_to != address(0), "To address is zero address");
            //remove all other owners of this nft
            approve(address(0), _tokenId);
            balances[_from] -=1;
            balances[_to] +=1;
            owners[_tokenId] = _to;

            emit Transfer(_from,_to, _tokenId);
        }

        // checks if OnERC721Received is implemented when seding NFT to a smart contract where nft will be stuck in contract
        function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public override payable
        {
            transferFrom(_from,_to, _tokenId);
            require(_OnERC721Received(),"receiver not implemented");

        }

        function safeTransferFrom(address _from, address _to, uint256 _tokenId) external override payable
        {
            safeTransferFrom(_from,_to,_tokenId,"");
        }

        // Oversimplified 
        function _OnERC721Received() private pure returns(bool)
        {
            return true;
        }

        function supportsInterface(bytes4 _interfaceId) public pure virtual returns(bool)
        {
            return _interfaceId == 0x80ac58cd;
        }

}