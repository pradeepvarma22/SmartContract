// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EventContract {
    string public name;
    string public uri;

    event GetNameEvent(address whoasked, string name);
    event SetNameEvent(address whoasked, string name);

    event GetURIEvent(address whoasked, string name);
    event SetURIEvent(address whoasked, string name);
    


    function getName() public  returns(string memory)
    {
        emit GetNameEvent(msg.sender, name);
        return name;
    }

    function setName(string memory _name) external {
        emit SetNameEvent(msg.sender,_name);
        name=_name;
    }

    function getURI() public returns(string memory)
    {
        emit GetURIEvent(msg.sender, uri);
        return uri;
    }
    
    function setURI(string memory _uri) external{
        emit SetURIEvent(msg.sender, _uri);
        uri = _uri;
    }

}