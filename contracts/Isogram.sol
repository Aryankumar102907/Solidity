// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IsogramChecker {

    // Function to check if a string is an isogram
    function isIsogram(string memory str) public pure returns (bool) {
        bytes memory bStr = bytes(str);
        uint256 len = bStr.length;

        for (uint256 i = 0; i < len; i++) {
            for (uint256 j = i + 1; j < len; j++) {
                if (bStr[i] == bStr[j]) {
                    return false; // Found a repeating character
                }
            }
        }
        return true; // No repeating characters
    }
}
