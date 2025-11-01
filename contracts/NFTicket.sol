// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTicket {
    string public name = "CeloGameTicket";
    string public symbol = "CGTicket";
    
    struct Ticket {
        uint256 eventId;
        uint256 price;
        bool used;
        string eventName;
    }
    
    mapping(uint256 => Ticket) public tickets;
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    
    uint256 private nextTokenId = 1;
    address public owner;
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event TicketMinted(address indexed to, uint256 tokenId, uint256 eventId);
    
    constructor() {
        owner = msg.sender;
    }
    
    function mintTicket(
        address to,
        uint256 eventId,
        uint256 price,
        string memory eventName
    ) public returns (uint256) {
        require(msg.sender == owner, "Chi owner duoc tao ticket");
        
        uint256 tokenId = nextTokenId++;
        tickets[tokenId] = Ticket(eventId, price, false, eventName);
        ownerOf[tokenId] = to;
        balanceOf[to]++;
        
        emit TicketMinted(to, tokenId, eventId);
        emit Transfer(address(0), to, tokenId);
        return tokenId;
    }
    
    function transfer(address to, uint256 tokenId) public {
        require(ownerOf[tokenId] == msg.sender, "Khong phai chu so huu");
        ownerOf[tokenId] = to;
        balanceOf[msg.sender]--;
        balanceOf[to]++;
        emit Transfer(msg.sender, to, tokenId);
    }
    
    function useTicket(uint256 tokenId) public {
        require(ownerOf[tokenId] == msg.sender, "Khong phai chu so huu");
        require(!tickets[tokenId].used, "Ticket da su dung");
        tickets[tokenId].used = true;
    }
}