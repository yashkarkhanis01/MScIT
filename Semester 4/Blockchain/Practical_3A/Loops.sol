// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract loopDemo {
    uint[] data;

    function forDemo() public returns (uint[] memory) {
        for (uint i = 0; i < 10; i++) {
            data.push(i);
        }
        return data;
    }

    function disp() public view returns (uint[] memory) {
        return data;
    }
}