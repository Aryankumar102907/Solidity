// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuadraticSolver {

    // Function to solve a quadratic equation
    function solveQuadratic(int256 a, int256 b, int256 c) public pure returns (string memory, int256, int256) {
        require(a != 0, "Coefficient a cannot be zero.");

        int256 discriminant = b * b - 4 * a * c;
        require(discriminant >= 0, "The equation has no real roots.");

        int256 sqrtDiscriminant = sqrt(uint256(discriminant));
        int256 twoA = 2 * a;

        int256 root1 = (-b + sqrtDiscriminant) / twoA;
        int256 root2 = (-b - sqrtDiscriminant) / twoA;

        string memory equation = getEquation(a, b, c);
        return (equation, root1, root2);
    }

    // Function to calculate the integer square root
    function sqrt(uint256 y) internal pure returns (int256) {
        if (y == 0) return 0;
        if (y <= 3) return 1;
        int256 z = int256(y);
        int256 x = z / 2 + 1;
        int256 result = z;
        while (x < result) {
            result = x;
            x = (z / x + x) / 2;
        }
        return result;
    }

    // Function to generate the quadratic equation in standard form as a string
    function getEquation(int256 a, int256 b, int256 c) internal pure returns (string memory) {
        return string(
            abi.encodePacked(
                intToString(a), "x^2 + ",
                intToString(b), "x + ",
                intToString(c), " = 0"
            )
        );
    }

    // Function to convert int256 to string
    function intToString(int256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        int256 temp = value;
        uint256 digits;
        bool negative = false;
        if (temp < 0) {
            negative = true;
            temp = -temp;
        }
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits + (negative ? 1 : 0));
        uint256 index = buffer.length;
        temp = value < 0 ? -value : value;
        while (temp != 0) {
            index--;
            buffer[index] = bytes1(uint8(48 + uint256(temp % 10)));
            temp /= 10;
        }
        if (negative) {
            buffer[0] = '-';
        }
        return string(buffer);
    }
}
