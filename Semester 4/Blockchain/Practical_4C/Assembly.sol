// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract InlineAssembly {
// Defining function
function add(uint256 a) public view returns (uint256 b) {
assembly {
let c := add(a, 16)
mstore(0x80, c)
{
let d := add(sload(c), 12)
b := d
}
b := add(b, c)
}
}
}