// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaVerse is ERC20, Ownable {
    
    uint public MTVTokenPrice= 1 ether;

    error AmountCannotBeZero();
    error OwnerIsRestrictedToBuyToken();
    error PleaseSendExactAmount();
    
    event TokenMinted(address MinterAddress, uint amount);
    event TokenPurchasedBy(address BuyerAddress, uint _Price);
    event UpdatedPrice(address UpdatedBy, uint _NewPrice);
    
    constructor() ERC20("MetaVerse", "MTV") {
    }

    function mint(uint256 amount) public onlyOwner{
        if(amount<=0){
           revert AmountCannotBeZero();
    }
        _mint(msg.sender, amount);
        emit TokenMinted(msg.sender, amount);
    }

    function BuyToken() public payable{
        if(msg.sender==owner()){
            revert OwnerIsRestrictedToBuyToken();
    }

        if (msg.value !=MTVTokenPrice) {
            revert PleaseSendExactAmount();
    }
    _transfer(owner(), msg.sender, 1);
    payable(owner()).transfer(msg.value);

    emit TokenPurchasedBy(msg.sender, msg.value);
    
    }

    function UpdateTokenPrice(uint NewPrice) public onlyOwner{
        if(NewPrice<=0){
            revert AmountCannotBeZero();
      }
    MTVTokenPrice=NewPrice;

    emit UpdatedPrice(msg.sender,NewPrice);
    
    }
}
