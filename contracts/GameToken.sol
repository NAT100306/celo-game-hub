// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GameToken {
    string public name = "CeloGameToken";
    string public symbol = "CGT";
    uint8 public decimals = 18;
    
    address public owner;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    constructor() {
        owner = msg.sender;
        totalSupply = 1000000 * 10**decimals;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Khong du token");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function mint(address to, uint256 value) public {
        require(msg.sender == owner, "Chi owner duoc mint");
        balanceOf[to] += value;
        totalSupply += value;
        emit Transfer(address(0), to, value);
    }
}