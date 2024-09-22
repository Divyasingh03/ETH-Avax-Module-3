// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public founder;

    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) ERC20(_name, _symbol) {
        founder = msg.sender;
        _mint(founder, _initialSupply ); // Use the ERC20 mint function and set initial supply
    }

    function mint(address recipient, uint256 amount) public {
        require(msg.sender == founder, "Unauthorized: Only the founder can mint tokens");
        _mint(recipient, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
