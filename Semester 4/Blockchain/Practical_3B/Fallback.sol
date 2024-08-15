// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint256 n;

    function set(uint256 value) external {
        n = value;
    }

    fallback() external payable {
        n = 0;
    }
}

contract Example {
    function callA(A a) public returns (bool) {
        // Correct the function name to call the `set(uint256)` function
        (bool success, ) = address(a).call(abi.encodeWithSignature("set(uint256)", 42)); // Example value 42
        require(success, "Call to set(uint256) failed");

        address payable payableA = payable(address(a));
        return (payableA.send(2 ether));
    }
}
