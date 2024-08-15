// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBlockchain {

    // Structure of a block
    struct Block {
        uint256 index;
        string data;
        uint256 timestamp;
        bytes32 previousHash;
        bytes32 hash;
        uint256 nonce;
    }

    // Array to store the chain of blocks
    Block[] public chain;

    // Event to log when a new block is added
    event BlockAdded(uint256 index, string data, bytes32 hash, bytes32 previousHash);

    // Constructor to initialize the chain with the genesis block
    constructor() {
        _createBlock(0, bytes32(0)); // Genesis block
    }

    // Function to create a new block and add it to the chain
    function _createBlock(uint256 _nonce, bytes32 _previousHash) internal returns (Block memory) {
        Block memory newBlock = Block({
            index: chain.length,
            data: "",
            timestamp: block.timestamp,
            previousHash: _previousHash,
            hash: _calculateHash(chain.length, "", block.timestamp, _previousHash, _nonce),
            nonce: _nonce
        });
        chain.push(newBlock);
        emit BlockAdded(newBlock.index, newBlock.data, newBlock.hash, newBlock.previousHash);
        return newBlock;
    }

    // Function to add a block with data and proof-of-work
    function addBlock(string memory _data, uint256 _nonce) public {
        bytes32 previousHash = chain.length > 0 ? chain[chain.length - 1].hash : bytes32(0);
        bytes32 newHash = _calculateHash(chain.length, _data, block.timestamp, previousHash, _nonce);
        require(_isValidHash(newHash), "Invalid hash");

        Block memory newBlock = Block({
            index: chain.length,
            data: _data,
            timestamp: block.timestamp,
            previousHash: previousHash,
            hash: newHash,
            nonce: _nonce
        });
        chain.push(newBlock);
        emit BlockAdded(newBlock.index, newBlock.data, newBlock.hash, newBlock.previousHash);
    }

    // Function to calculate the hash of a block
    function _calculateHash(
        uint256 _index,
        string memory _data,
        uint256 _timestamp,
        bytes32 _previousHash,
        uint256 _nonce
    ) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_index, _data, _timestamp, _previousHash, _nonce));
    }

    // Function to validate the hash (simple proof-of-work)
    function _isValidHash(bytes32 _hash) internal pure returns (bool) {
        return uint256(_hash) % 100000 == 0; // Simplified proof-of-work condition
    }

    // Function to get the length of the blockchain
    function getChainLength() public view returns (uint256) {
        return chain.length;
    }

    // Function to get a block by index
    function getBlock(uint256 _index) public view returns (Block memory) {
        require(_index < chain.length, "Block index out of range");
        return chain[_index];
    }
}