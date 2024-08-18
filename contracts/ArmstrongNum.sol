// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArmstrongNumber {
    function isArmstrong(uint256 num) public pure returns (bool) {
        uint256 sum = 0;
        uint256 temp = num;
        uint256 digits = 0;
        uint256 n = num;

        // Calculate number of digits in num
        while (n != 0) {
            digits++;
            n /= 10;
        }

        // Calculate the sum of digits raised to the power of the number of digits
        while (temp != 0) {
            uint256 digit = temp % 10;
            sum += power(digit, digits);
            temp /= 10;
        }

        // Compare the sum with the original number
        return sum == num;
    }

    function power(uint256 base, uint256 exp) internal pure returns (uint256) {
        uint256 result = 1;
        for (uint256 i = 0; i < exp; i++) {
            result *= base;
        }
        return result;
    }
}
