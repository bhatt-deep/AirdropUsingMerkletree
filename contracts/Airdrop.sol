// SPDX-License-Identifier: MIT

pragma solidity ^0.6.10;

import "./ERC20Token.sol";
import "./MerkleProof.sol";

contract AirDrop {
    address private owner;
    ERC20Token private token;
    bytes32 public usersListMerkleRoot;
    mapping(address => bool) private redeemed;
    uint256 maxRedeemAmount;

    event Redeem(address indexed account, uint256 amount);

    constructor(ERC20Token _token, bytes32 _usersListMerkleRoot, uint256 _maxRedeemAmount) public {
        owner = msg.sender;
        token = _token;
        usersListMerkleRoot = _usersListMerkleRoot;
        maxRedeemAmount = _maxRedeemAmount;
    }

    function redeem( uint256 _path, bytes32[] memory _witnesses, uint256 _amount) public {

        require(_amount <= maxRedeemAmount, " amount must be less than max redeem amount.");
        require(!redeemed[msg.sender], "You already redeemed.");

        bytes32 leaf = keccak256(abi.encodePacked(uint8(0x00), msg.sender));

        require(MerkleProof.verify(_witnesses,usersListMerkleRoot,_path, leaf),
        "Error: address not in the list or wrong proof provided.");
        
        redeemed[msg.sender] = true;

        token.transfer(msg.sender, _amount);

        emit Redeem(msg.sender, _amount);
    
    }

    function updateMerkleRoot(bytes32 _usersListMerkleRoot)
        public
        onlyOwner
    {
        usersListMerkleRoot = _usersListMerkleRoot;
    }
    
    //Modifiers
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Error: only owner can perform this transaction."
        );
        _;
    }
}