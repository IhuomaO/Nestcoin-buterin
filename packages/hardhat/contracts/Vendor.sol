pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

 //Variables
    address public _owner;

    YourToken public yourToken;

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

    uint8[] public _purchasedRewardsID; //this is an array of Ids but it is always empty at the beginning of the SC.
    mapping(address => uint8[]) public _purchasedRewards; //mapping holds the addresses to the purchased rewards array.


    constructor(address tokenAddress) {
       yourToken = YourToken(tokenAddress);
        _owner = msg.sender;
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

    //function to check if list provided in array is the actual list of loyal customers
    function _isListActual(address[] memory _arrayOfLoyalCustomers)
        public 
        view
        returns(bool, uint256)
    {
        for(uint i = 0; i < _arrayOfLoyalCustomers.length; i++)
            {
                if(_arrayOfLoyalCustomers[i] == _loyalCustomers[i]){
                 return (true, i);
            }
                return (false, 0);
    }
}

    // YET TO BE TESTED!!!**
    //ADMIN FUNCTION 01
    //this adds a loyal customer to the loyalCustomer Array
    function _addLoyalCustomer(address _loyalCustomer) public {
        require(msg.sender == _owner, "Only the Owner can add new customers");
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_loyalCustomer);
        require(isLoyalCustomer != true, "Can't add Address twice");
        _loyalCustomers.push(_loyalCustomer);
        //add the customer to the mapping that stores the purchased rewards and assign an empty array of IDs to him.
        _purchasedRewards[_loyalCustomer] = _purchasedRewardsID;
    }

    //ADMIN FUNCTION 02
    //function allows the owner to send reward tokens to loyal customers
    function _rewardLoyalCustomers(address _loyalCustomer, uint256 _amount)
        public
        payable
    {
        require(msg.sender == _owner, "Only the Owner can reward customers");
        require(
            yourToken.balanceOf(msg.sender) > _amount,
            "Insufficient Balance for NestOil"
        );
        (bool isLoyalCustomer, ) = _isLoyalCustomer(_loyalCustomer);
        require(
            isLoyalCustomer == true,
            "Can't reward this Address. Not a loyal Customer"
        );
        yourToken.transfer(_loyalCustomer, _amount);
    }

    //ADMIN FUNCTIONS 03
    //function to return admin balance
    function _viewAdminBalance() public view returns (uint256) {
        return yourToken.balanceOf(_owner);
    }

    //ADMIN FUNCTIONS 04
    //function to return a list of all the loyalCustomers
    function _viewAllLoyalCustomers() public view returns (address[] memory) {
        return _loyalCustomers;
    }

    //ADMIN FUNCTIONS 05
    //function that allows for sending(batching) of transactions to multiple addresses at once
    //_arrayOfloyalCustomers = array of loyal customer addresses
    //_amount = The amount of tokens all addresses will receive
    function multiSendTokensToCustomers(address[] memory _arrayOfLoyalCustomers, uint256 _amount) 
        public 
        payable 
        returns(bool)
    {
        require(msg.sender == _owner,"Not the owner");

        uint256 vendorBalance = yourToken.balanceOf(address(this));

        require(vendorBalance >= _amount, "Insufficient Balance to send tokens");

        (bool isActual, ) = _isListActual(_arrayOfLoyalCustomers);
        require(
            isActual == true,
            "Can't reward these addresses. Not the actual list"
        );

        for(uint i = 0; i < _loyalCustomers.length && i <= 200; i++) {
            if(_loyalCustomers[i] != address(0)) {
            yourToken.transfer(_loyalCustomers[i], _amount);
            }
        }
        return true;
    }

    ///ADMIN FUNCTIONS 06
    //function to self destruct
    function selfDestruct(address _address) public { 
        require(msg.sender == _owner, "only the owner can call self destruct");
        selfdestruct(payable(_address)); 
    }

    //USER FUNCTIONS
    //USER FUNCTIONS
    //USER FUNCTIONS

    //USER FUNCTIONS 02
    //function to return user balance
    function _viewUserBalance(address _loyalCustomerAddress)
        public
        view
        returns (uint256)
    {
        return yourToken.balanceOf(_loyalCustomerAddress);
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
        require(yourToken.balanceOf(msg.sender) > _amount, "Insufficient Balance");
        yourToken.transfer(_to, _amount);
    }

    // YET TO BE TESTED!!!**
    //USER FUNCTIONS 06
    function _purchaseRewards(uint8[] memory chosenIds) public payable {
        (bool isLoyalCustomer, ) = _isLoyalCustomer(msg.sender);
        require(
            isLoyalCustomer == true,
            "Only a loyal customer is allowed to purchase these Items"
        );
        uint256 _totalCost = _findTotalCost(chosenIds);
        require(_totalCost > 0, "You must click an Item");
        require(yourToken.balanceOf(msg.sender) > _totalCost, "Insufficient Funds");
        yourToken.burn(_totalCost);
        _updatePurchasedRewardsMapping(msg.sender, chosenIds); //update the mapping variable that tracks a users address to purchased Rewards
    }

    // YET TO BE TESTED!!!**
    //HELPER FUNCTION 01
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

    // YET TO BE TESTED!!!**
    //HELPER FUNCTION 02
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

    //HELPER FUNCTION 03
    //function that replaces the _purchasedRewards mapping with the new array after combining
    function _updatePurchasedItems(
        uint8[] memory _updatedList,
        address _address
    ) public {
        _purchasedRewards[_address] = _updatedList;
    }

    //HELPER FUNCTION 04
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

    function _updatePurchasedRewardsMapping(
        address _address,
        uint8[] memory chosenIds
    ) public {
        uint8[] memory _existingIds;
        _existingIds = _getListOfExistingPurchasedItems(_address); //HELPER FUNCTION 04
        uint8[] memory _updatedListIds;
        _updatedListIds = _addTwoArrays(_address, chosenIds); //HELPER FUNCTION 02
        _updatePurchasedItems(_updatedListIds, _address); //HELPER FUNCTION 03
    }
}
