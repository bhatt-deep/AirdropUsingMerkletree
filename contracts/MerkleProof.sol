// SPDX-License-Identifier: MIT

pragma solidity ^0.6.10;
/**
 * @title MerkleProof
 * @dev Merkle proof verification based on
 * https://github.com/ameensol/merkle-tree-solidity/blob/master/src/MerkleProof.sol
 */
library MerkleProof {
 
  function verify(
    bytes32[] memory witnesses,
    bytes32 root,
    uint256 path,
    bytes32 leaf
  )
    internal
    pure
    returns (bool)
  {
    for (uint16 i = 0; i < witnesses.length; i++) {
            if ((path & 0x01) == 1) {
                leaf = keccak256(
                    abi.encodePacked(uint8(0x01), witnesses[i], leaf)
                );
            } else {
                leaf = keccak256(
                    abi.encodePacked(uint8(0x01), leaf, witnesses[i])
                );
            }
            path /= 2;
        }

    // Check if the computed hash (root) is equal to the provided root
    return leaf == root;
  }
}