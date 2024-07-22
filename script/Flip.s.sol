// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../src/Contract.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract HackMeIfYouCanSolution is Script {
    HackMeIfYouCan public hackMeIfYouCan;

    function run() external {
        uint256 id;
        assembly {
            id := chainid()
        }
        if (id == 11155111) {
            hackMeIfYouCan = HackMeIfYouCan(0x9D29D33d4329640e96cC259E141838EB3EB2f1d9);
        } else {
            console.log("Deploying contract...");
            bytes32[15] memory data;
            for (uint256 i = 0; i < 15; i++) {
                bytes32 value = bytes32(uint256(i));
                data[i] = value;
            }
            hackMeIfYouCan = new HackMeIfYouCan(bytes32(uint256(100)), data);
            vm.stopBroadcast();
        }
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        hackMeIfYouCan.flip(false);
        console.log('ConsecutiveWins', hackMeIfYouCan.getConsecutiveWins(vm.envAddress("PUBLIC_KEY")));
    }
}