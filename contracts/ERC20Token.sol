// SPDX-License-Identifier: MIT

pragma solidity ^0.6.10;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";

contract ERC20Token is ERC20Capped {
    address private owner;

    constructor(
        string memory name,
        string memory symbol,
        uint256 totalsupply
    ) public ERC20(name, symbol) ERC20Capped(totalsupply) {
        owner = msg.sender;
    }

    function mint(address account, uint256 amount) public {
        require(msg.sender == owner, "Error: only owner can mint.");
        super._mint(account, amount);
    }
}