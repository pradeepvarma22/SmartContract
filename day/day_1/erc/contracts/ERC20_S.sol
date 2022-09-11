// SPDX-License-Identifier: MIT
// https://eips.ethereum.org/EIPS/eip-20
pragma solidity ^0.8.9;

interface EIP20I {
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
}

contract ERC20 is EIP20I {


    uint256 private _totalSupply;
    string private _name;
    string private _symbol;


    mapping(address=>uint256) private _balances;
    mapping(address => mapping (address=>uint256)) private _allowances;


    constructor(string memory name, string memory symbol)
    {
        _name=name;
        _symbol = symbol;
    }


    function totalSupply() public override view returns (uint256)
    {
        return _totalSupply;
    }



    function balanceOf(address owner) public override view returns (uint256 balance)
    {
        return _balances[owner];
    }

    function transfer(address to, uint256 value) public override returns (bool success)
    {
        require(_balances[msg.sender] >= value, "Low Balance");             // 2 cases at a time 1. overflow 2.condition
        require(to != address(0), "Receiver is an zero address");
        
        //overflow checked on up
        unchecked {
            _balances[msg.sender] -= value;
            _balances[to] += value;
        }
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Withdraw Functions
    function allowance(address owner, address spender) public override view returns (uint256)
    {
        return _allowances[owner][spender];
    }


    function approve(address spender, uint256 value) public override returns (bool success)
    {

        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success)
    {
        address spender = msg.sender;
        require(_to!= address(0),"transfer to the zero address");
        require(_from != address(0), "transfer from the zero address");
        require(allowance(_from,spender) >= _value, "amount requested is to high");
        require(balanceOf(_from) >=_value, "main owner balace is too low");
        _allowances[_from][spender] -= _value;

        _balances[_from] -= _value;
        _balances[_to] += _value;
        emit Transfer(_from, _to, _value);

        return true;
    }



}
