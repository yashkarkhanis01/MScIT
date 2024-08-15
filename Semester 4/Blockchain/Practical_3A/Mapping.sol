// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LedgerBalance {
    mapping(address => uint256) public balances;
    function updateBalance(uint256 newBalance) public {
        balances[msg.sender] = newBalance;
    }
}
contract Updater {
    function updateBalance() public returns (uint256) {
        LedgerBalance ledgerBalance = new LedgerBalance();
        return ledgerBalance.balances(address(this));
    }
}