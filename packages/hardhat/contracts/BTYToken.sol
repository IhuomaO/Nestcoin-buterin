// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BTRToken is ERC20, Ownable {
    //Variables
    address public _owner;
    address[] public _loyalCustomers; //an array of loyal customers

    mapping(address => uint256) public _balances; //mapping of balances

    _Reward[] public _rewardsPool; //array to hold all the rewards available

    struct _Reward {
        uint8 id;
        string rewardName;
        uint256 rewardCost;
    } //basic template of a reward

    //function to create a reward
    function _addReward(
        uint8 id,
        string memory rewardName,
        uint256 rewardCost
    ) public {
        _rewardsPool.push(_Reward(id, rewardName, rewardCost));
    }

    //function to create all rewards
    function _createRewardPool() internal {
        _addReward(0, "Couples Coupon", 10);
        _addReward(1, "LateNight Movie", 20);
        _addReward(2, "Backstage Pass", 30);
        _addReward(3, "Birthday Pass", 40);
        _addReward(4, "Kiddies Fun", 50);
    }

    mapping(address => uint8[]) public _purchasedRewards; //mapping holds the addresses to the purchased rewards array.

    constructor() ERC20("Buterite", "BTR") {
        _owner = msg.sender;
        _mint(msg.sender, 1000);
        _createRewardPool(); //function to create all available rewards
    }

    //ADMIN FUNCTIONS
    //ADMIN FUNCTIONS
    //ADMIN FUNCTIONS

    //function to check if a customer's address is in the array
    function _isLoyalCustomer(address _address)
        public
        view
        returns (bool, uint256)
    {
        for (uint256 s = 0; s < _loyalCustomers.length; s += 1) {
            if (_address == _loyalCustomers[s]) return (true, s);
        }
        return (false, 0);
    }

    //ADMIN FUNCTION 01
    //this adds a loyal customer to the loyalCustomer Array
    function _addLoyalCustomer(address _loyalCustomer) public {
        require(msg.sender == _owner, "Only the Owner can add new customers");
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_loyalCustomer);
        require(isLoyalCustomer != true, "Can't add Address twice");
        _loyalCustomers.push(_loyalCustomer);
        //add the cuustomer to the mapping that stores the purchased rewards
        //what is the logic?? map the address to an empty array at creation
    }

    //ADMIN FUNCTION 01
    //function allows the owner to send reward tokens to loyal customers
    function _rewardLoyalCustomers(address _loyalCustomer, uint256 _amount)
        public
        payable
    {
        require(msg.sender == _owner, "Only the Owner can reward customers");
        require(
            balanceOf(msg.sender) > _amount,
            "Insufficient Balance for NestOil"
        );
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_loyalCustomer);
        require(
            isLoyalCustomer == true,
            "Can't reward this Address. Not a loyal Customer"
        );
        transfer(_loyalCustomer, _amount);
    }

    //ADMIN FUNCTION 02
    //function to allow only the owner to mint extra tokens
    function _extraMint(uint256 amount) public payable {
        require(msg.sender == _owner, "Only the Owner can mint new tokens");
        _mint(msg.sender, amount);
    }

    //ADMIN FUNCTIONS 03
    //function to return admin balance
    function _viewAdminBalance() public view returns (uint256) {
        return balanceOf(_owner);
    }

    //ADMIN FUNCTIONS 04
    //function to return a list of all the loyalCustomers
    function _viewAllLoyalCustomers() public view returns (address[] memory) {
        return _loyalCustomers;
    }

    //USER FUNCTIONS
    //USER FUNCTIONS
    //USER FUNCTIONS

    //USER FUNCTIONS 02
    //function to return admin balance
    function _viewUserBalance(address _loyalCustomerAddress)
        public
        view
        returns (uint256)
    {
        return balanceOf(_loyalCustomerAddress);
    }

    //USER FUNCTIONS 03
    //function allows loyalCustomers to transfer tokens between themselves.
    function _loyalCustomersTransferTokens(address _to, uint256 _amount)
        public
        payable
    {
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_to);
        require(
            isLoyalCustomer == true,
            "Only a loyal customer is allowed to receive Tokens"
        );
        require(_amount > 0, "You can't transfer 0 tokens");
        require(balanceOf(msg.sender) > _amount, "Insufficient Balance");
        transfer(_to, _amount);
    }

    //USER FUNCTIONS 06
    function _purchaseRewards(uint8[] memory chosenIds) public payable {
        (bool isLoyalCustomer, ) = _isLoyalCustomer(msg.sender);
        require(
            isLoyalCustomer == true,
            "Only a loyal customer is allowed to purchase these Items"
        );
        uint256 _totalCost = _findTotalCost(chosenIds);
        require(_totalCost > 0, "You must click an Item");
        require(balanceOf(msg.sender) > _totalCost, "Insufficient Funds");
        _burn(msg.sender, _totalCost);
        //uupdate whateever data variable that holds the user's purchased rewards
    }

    function _findTotalCost(uint8[] memory chosenIds)
        public
        view
        returns (uint256)
    {
        uint256 _totalCost = 0;
        for (uint256 s = 0; s < chosenIds.length; s += 1) {
            uint8 chosenRewardID = chosenIds[s];
            uint256 chosenRewardCost = _rewardsPool[chosenRewardID].rewardCost;
            _totalCost += chosenRewardCost;
        }
        return _totalCost;
    }

    //function that updates the list of items purchased
    function _addTwoArrays(address _address, uint8[] memory _justPurchased)
        public
        returns (uint8[] memory)
    {
        uint8[] storage _updatedList = _purchasedRewards[_address]; //create an array that references the existing one in the mapping
        for (uint256 s = 0; s < _justPurchased.length; s += 1) {
            _updatedList.push(_justPurchased[s]); //add the items from the new one to the old one
        }
        return _updatedList; //final array is updated
    }

    //function that replaces the _purchasedRewards mapping with the new array after combining
    function _updatePurchasedItems(
        uint8[] memory _updatedList,
        address _address
    ) public {
        _purchasedRewards[_address] = _updatedList;
    }

    //function that retrieves the array list of uint8 ids from the exsitiing _purchasedRewards mapping
    function _getListOfExistingPurchasedItems(address _address)
        public
        view
        returns (uint8[] memory)
    {
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_address);
        require(isLoyalCustomer == true, "You are checking an Illegal Address");
        return _purchasedRewards[_address];
    }
}
