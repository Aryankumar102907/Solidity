// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EuropeanRoulette {
    address public player;
    uint256 public betAmount;
    uint256[] public rouletteNumbers;
    uint256 public lastSpinResult;

    constructor() payable {
        // Initialize the roulette numbers (0-36)
        for (uint256 i = 0; i <= 36; i++) {
            rouletteNumbers.push(i);
        }
    }

    // Function to place a bet
    function placeBet(uint256 number) public payable {
        require(player == address(0), "Another bet is already active.");
        require(msg.value > 0, "Bet amount must be greater than 0.");
        require(number >= 0 && number <= 36, "Number must be between 0 and 36.");

        player = msg.sender;
        betAmount = msg.value;

        // Spin the roulette wheel and get the result
        uint256 outcome = spinRoulette();

        // Store the last spin result for output
        lastSpinResult = outcome;

        // Determine win or loss and transfer Ether accordingly
        if (outcome == number) {
            uint256 prize = betAmount * 36; // European roulette payout for a straight-up bet
            payable(player).transfer(prize);
            emit BetResult(player, number, outcome, true);
        } else {
            emit BetResult(player, number, outcome, false);
        }

        // Reset player and bet amount for the next round
        player = address(0);
        betAmount = 0;
    }

    // Internal function to simulate the roulette spin
    function spinRoulette() internal view returns (uint256) {
        uint256 randomHash = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, player)));
        return rouletteNumbers[randomHash % rouletteNumbers.length];
    }

    // Function to retrieve the result of the last spin
    function getLastSpinResult() public view returns (uint256) {
        return lastSpinResult;
    }

    // Fallback function to accept Ether
    receive() external payable {}

    // Function to withdraw contract balance (only by the owner)
    function withdraw() public {
        require(player == address(0), "Cannot withdraw during an active bet.");
        payable(msg.sender).transfer(address(this).balance);
    }

    // Event to log the result of each bet
    event BetResult(address indexed player, uint256 betNumber, uint256 outcomeNumber, bool won);
}
