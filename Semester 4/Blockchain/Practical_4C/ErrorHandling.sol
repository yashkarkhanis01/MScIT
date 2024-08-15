// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorDemo {
    function getSum(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 sum = a + b;
        //require(sum < 255, "Invailid");
        assert(sum<255);
        return sum;
    }
}