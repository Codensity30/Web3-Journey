// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function convertETHtoUSD(uint eth) internal view returns (uint){
            return ((eth * getETHPrice())/1e18);
    }

    function getETHPrice() internal view returns (uint) {
        // constructing it using the sepolia address to get ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (,int answer,,,) = priceFeed.latestRoundData();
        // since ETH has 18 deciamal places where as Chainlink return 8 decimal places
        return uint(answer*1e10);
    }   
}
