// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GameHub {
    address public owner;
    address public gameToken;
    address public nftTicket;
    
    mapping(address => uint256) public playerScores;
    mapping(address => uint256) public lastPlayTime;
    
    event GamePlayed(address player, uint256 score, uint256 reward);
    event TournamentCreated(uint256 tournamentId, uint256 prizePool);
    
    constructor(address _gameToken, address _nftTicket) {
        owner = msg.sender;
        gameToken = _gameToken;
        nftTicket = _nftTicket;
    }
    
    function playGame() public returns (uint256) {
        uint256 score = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 1000 + 1;
        
        playerScores[msg.sender] = score;
        lastPlayTime[msg.sender] = block.timestamp;
        
        emit GamePlayed(msg.sender, score, score * 10**18);
        return score;
    }
    
    function getPlayerStats(address player) public view returns (uint256 score, uint256 lastPlay) {
        return (playerScores[player], lastPlayTime[player]);
    }
    
    function createTournament(uint256 prizePool) public {
        require(msg.sender == owner, "Chi owner duoc tao giai dau");
        uint256 tournamentId = uint256(keccak256(abi.encodePacked(block.timestamp)));
        emit TournamentCreated(tournamentId, prizePool);
    }
}