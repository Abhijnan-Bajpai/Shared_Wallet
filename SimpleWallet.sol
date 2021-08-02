//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

//OpenZeppelin contract for better security
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    // address owner;
    
    mapping(address => uint) public allowance;
    
    
    // A modifier which ensures the security of certain transactions by limiting their access to the owner
    // Not required after import of Ownable.sol
    // modifier onlyOwner() {
    //     require(msg.sender == owner, "You don't have the required privileges");
    //     _;
    // }
    
    // Setting specific allowance for each non-owner user
    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    modifier onlyOwnerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }
    
    // Need to ensure that when owner is reducing allowance, it doesn't go below zero
    function reduceAllowance(address _who, uint _amount) internal onlyOwnerOrAllowed(_amount) {
        allowance[_who] -= _amount;
    }
}

contract SimpleWallet is Allowance {
    
    function withdrawMoney(address payable _to, uint _amount) public onlyOwnerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds in the contract");
        if(!isOwner())
        {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
    
    receive() external payable {
        
    }
    
}