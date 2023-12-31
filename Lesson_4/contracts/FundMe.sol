// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint minUsd = 50*1e18;
    address[] public funders;
    mapping(address => uint) public howMuchFunded;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(convertETHtoUSD(msg.value) >= minUsd, "You don't have enough ETH!");
        funders.push(msg.sender);
        howMuchFunded[msg.sender] += msg.value;
    }

    function convertETHtoUSD(uint eth) public view returns (uint){
        return ((eth * getETHPrice())/1e18);
    }

    function getETHPrice() public view returns (uint) {
        // constructing it using the sepolia address to get ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (,int answer,,,) = priceFeed.latestRoundData();
        // since ETH has 18 deciamal places where as Chainlink return 8 decimal places
        return uint(answer*1e10);
    }

    function withdraw() public {
        require(owner==msg.sender,"Unauthorized! You are not the owner of the contract");

        // resetting the mapping and array to zero
        for(uint i=0; i<funders.length; i++){
            howMuchFunded[funders[i]] = 0;
        }
        funders = new address[](0);
        // to send money we have 3 ways
        // transfer, send and call
        (bool sent,) = payable(owner).call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
