// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalindromeChecker {
    function isPalindrome(uint256 number) public pure returns (bool) {
        uint256 reversedNumber = 0;
        uint256 originalNumber = number;

        while (number != 0) {
            uint256 digit = number % 10;
            reversedNumber = reversedNumber * 10 + digit;
            number /= 10;
        }

        return originalNumber == reversedNumber;
    }
}