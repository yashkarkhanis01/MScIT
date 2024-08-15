// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ProofOfWork {

    // This event will be emitted when a successful proof of work is found
    event ProofOfWorkSolved(address indexed solver, uint256 nonce, bytes32 hash);

    // Stores the data and required difficulty
    string public data;
    uint256 public difficulty;
    
    // Mapping to store solved nonces and associated hashes
    mapping(uint256 => bytes32) public solutions;

    // Constructor to initialize the contract with data and difficulty
    constructor(string memory _data, uint256 _difficulty) {
        data = _data;
        difficulty = _difficulty;
    }

    // Function to perform a proof of work
    function solveProofOfWork(uint256 nonce) public returns (bool) {
        // Prepare the data to hash
        bytes32 hash = keccak256(abi.encodePacked(data, nonce));
        
        // Check if the hash meets the difficulty requirement
        if (uint256(hash) % (2 ** difficulty) == 0) {
            solutions[nonce] = hash;
            emit ProofOfWorkSolved(msg.sender, nonce, hash);
            return true;
        } else {
            return false;
        }
    }
}