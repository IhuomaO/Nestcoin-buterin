pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  // how do we get the rewards into the contract???
   struct rewards {
      string name;
      string description;
      uint256 amount;
  }

  // To track ownership of rewards
   mapping (address => rewards[]) public rewardOwner;

  // To track properties of reward
   mapping (string => uint256) public rewardProperties;

  // To keep track of how many tokens each address received
  mapping (address => uint256) public tokenTrialDrops;

  // To track balances on addresses
  mapping(address => uint) public balances;

  
  // array of loyal customer's addresses & how do we get this too???
  address[]  listOfCustomersAddresses;

  //
  uint256 public dropUnitPrice;

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

   // Emit event on successful distribution of tokens to loyal customers
   event TokenAirdrop( address vendor, address addressOfToken, uint256 numOfRecipients);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  /**
  * @notice Allow vendor to transfer token to loyal customers
  */
      // function batchTokensTransfer(  _yourToken, _usersWithdrawalAccounts, _amounts ) public ownerOnly {
      //   require(_usersWithdrawalAccounts.length == _amounts.length);
      //     for (uint i = 0; i < _usersWithdrawalAccounts.length; i++) {
      //         if (_usersWithdrawalAccounts[i] != 0x0) {
      //           _yourToken.transfer(_usersWithdrawalAccounts[i], _amounts[i]);
      //         }
      //     }
      // }

      function multiValueTokenAirdrop(address _addressOfToken,  address[] memory _recipients, uint256[] memory _values ) public payable returns(bool) {
          ERCInterface token = ERCInterface(_addressOfToken);
          require(_recipients.length == _values.length, "Total number of recipients and values are not equal");

          uint256 price = _recipients.length.mul(dropUnitPrice);

          require( msg.value >= price, "Not enough ETH sent with transaction!");
          
          for(uint i = 0; i < _recipients.length; i++) {
              if(_recipients[i] != address(0) && _values[i] > 0) {
                  token.transferFrom(msg.sender, _recipients[i], _values[i]);
              }
          }
          emit TokenAirdrop(msg.sender, _addressOfToken, _recipients.length);
          return true;

        }

  // ToDo: create a transferTokens() function:
      function transferTokens( address _receiver, uint256 tokenAmountToTransfer) public {
        // Check that the requested amount of tokens to sell is more than 0
        require(tokenAmountToTransfer > 0, "Specify an amount of token greater than zero");

        (bool sent) = yourToken.transferFrom(msg.sender, _receiver, tokenAmountToTransfer);
        require(sent, "Failed to transfer tokens between customers");

 
      }

  // To allow a customer to view balance.
      function viewBalance (address _to) {
        balanceOf[_to];                         
    }

  // To allow customers exchange their tokens for rewards.
     function exchangeTokens( chosenRewards[] ) public {
        // Check that the chosen number of rewards to exchange is more than 0
        require(chosenRewards.length > 0, "A reward item must be chosen");

        // Check that the user's token balance is enough to do the swap. We need to determine to sum all the value for the rewards in the array if it is more than one reward
        uint256 userBalance = yourToken.balanceOf(msg.sender);
        require(userBalance >= chosenRewards.value , "Your token balance is insufficient to claim the reward");
     
       // Transfer/Burn token to vendor 
         (bool sent) = yourToken.transferFrom(msg.sender, address(this), chosenRewards.value);
          require(sent, "Failed to transfer tokens from user to vendor");

      // Update customer's address as owner of reward(s), how do we do this??

     }

  // To allow a customer to view  reward(s).
      function viewRewards (address _to) {
                                
    }

}
