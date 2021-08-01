//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

//OpenZeppelin contract for better security
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SimpleWallet is Ownable {
    
    // address owner;
    
    
    // A modifier which ensures the security of certain transactions by limiting their access to the owner
    // Not required after import of Ownable.sol
    // modifier onlyOwner() {
    //     require(msg.sender == owner, "You don't have the required privileges");
    //     _;
    // }
    
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }
    
    receive() external payable {
        
    }
    
}