// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Roulette {

    address public owner;
    uint256[] internal rouletteNumbers;
    uint256 _playerbal = 100;
    uint256 _ownerbal = 1000;
    uint256 _betnum= 0;
    uint256 _betval = 0;

    constructor() {
        owner = msg.sender;
        for (uint256 i = 0; i <= 36; i++) {
            rouletteNumbers.push(i);
        }
    }

    modifier notOwner() {
        require(msg.sender != owner, "You are the owner.");
        _;
    }

    function number(uint256 num, uint256 val) public notOwner{
        _betnum = num;
        _betval = val;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    function Wheel() public view onlyOwner returns(uint256) {
        uint256 randomHash = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
        return rouletteNumbers[randomHash % rouletteNumbers.length];
    }

    
    function currentbal() public{
        uint256 n = Wheel();
        if (n == _betnum) {
            _playerbal += _betval;
            _ownerbal -= _betval;
        } 
        else
        {
            _playerbal -= _betval;
            _ownerbal += _betval;
        }
        console.log("Player Balance",_playerbal);
        console.log("Owner Balance",_ownerbal);
    }

}