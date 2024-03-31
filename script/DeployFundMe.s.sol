// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    
    function run() public {
 


        vm.startbroadcast();
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();
        return (fundMe, helperConfig);

    }
}
