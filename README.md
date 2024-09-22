# ERC-20 Hello Token Contract

This Solidity program is a demonstration of ERC-20 Token with support of transfer, minting, and burning of coins.

## Description

This Solidity program defines an ERC20 token with essential functionalities. It includes functions for minting, where only the founder of the token can create new tokens, and burning, which allows any holder to destroy their tokens. Additionally, the contract supports standard ERC20 transfer and allowance operations, enabling tokens to be transferred between any accounts on the blockchain. It imports the IERC20 interface from [OpenZeppelin](https://www.openzeppelin.com/)

# Contract Overview
The Token contract is a basic implementation of an ERC20-like token. It features the following components:

1) owner : The address of owner which gets assigned when the contract is deployed

# Usage
Constructor
The contract constructor initializes the contract with an initial supply of tokens. The deploying address becomes the founder of the contract and holds the entire initial supply.

solidity
constructor(uint _initialSupply);


# Functions

solidity
mint(address recipient, uint256 amount);
// Allows the founder to mint new tokens and add them to a specified address's balance.


solidity
burn(uint256 amount);
// Allows users to burn (destroy) a specific amount of their tokens.


solidity
transferTo(address recipient, uint256 amount);
// Transfer amount of tokens from sender to recipient


## Getting Started

### Executing Program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix Ethereum](https://remix.ethereum.org/).

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";


contract ERC20 is Context, IERC20 {
    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

   
    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

   
    function name() public view virtual returns (string memory) {
        return _name;
    }

  
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

  
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

  
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

   
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);

        return true;
    }

    
  
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

   
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);

        return true;
    }

   
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    
    function burn(address account, uint256 amount) public virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

  
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}



```

## Help
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version), and then click on the "Compile Token.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Token" contract from the dropdown menu, and then click on the "Deploy" button.

## Authors
Divya Singh

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
