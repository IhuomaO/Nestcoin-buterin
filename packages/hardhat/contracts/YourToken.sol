pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20, ERC20Burnable, Ownable  {


    constructor() ERC20("Buterite", "BTR") {
         _mint(msg.sender, 1000 * 10 ** 18);
         // _owner = msg.sender;
      //   _createRewardPool(); //function to create all available rewards
    }

    //ADMIN FUNCTION 02
    //function to allow only the owner to mint extra tokens
    function _extraMint(uint256 amount) public payable onlyOwner  {
       // require(msg.sender == _owner, "Only the Owner can mint new tokens");
        _mint(msg.sender, amount);
    }
    
}