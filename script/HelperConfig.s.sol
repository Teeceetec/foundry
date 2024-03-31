//SPDX-License-Identifier: MIT
 pragma solidity ^0.8.19;

 import {MockV3Aggregator} from "../test/MockV3Aggregator.sol";
 import {Script} from "forge-std/Script.sol";

 contract HelperConfig is Script {
    NetworkConig public activeNetworkConig;

    uint8 public constant DECIMALS = 0;
    int256 public constant INITIAL_PRICE = 2000e8

   struct NetworkConig{
    address priceFeed;
   }

    event HelperConfig_CreatedMockPriceFeed(address priceFeed);

    constructor () {
      if(block.chainid == 11155111) {
        activeNetworkConig = getSepoliaNetwork();
      } else {
        activeNetworkConig = getOrCreateAnvilEthConfig();
      }
    }

    function getSepoliaNetwork public returns(NetworkConig memory sepoliaNetworkConfig) {
       sepoliaNetworkConfig = NetworkConig({
        priceFeed:  0x694AA1769357215DE4FAC081bf1f309aDC325306 // ETH / USD
       })
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConig memory anvilNetworkConfig) {
      //check to see if we set ana active network config.
      if(activeNetworkConig.priceFeed != address(0)) {
        return activeNetworkConig
      }

      vm.startbroadcast();
       MockV3Aggregator mockPriceFeed = MockV3Aggregator(
         DECIMALS,
         INITIAL_PRICE
       );
       vm.stopBroadcast();
       emit HelperConfig_CreatedMockPriceFeed(address(mockPriceFeed));

      anvilNetworkConfig = NetworkConig({

      })
    }
 }