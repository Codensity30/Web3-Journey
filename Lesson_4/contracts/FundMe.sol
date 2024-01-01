// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "Lesson_4/contracts/PriceConverter.sol";

contract FundMe {
    uint constant MINIMUM_USD = 50*1e18;
    address[] public funders;
    mapping(address => uint) public howMuchFunded;
    address public immutable OWNER;

    constructor() {
        OWNER = msg.sender;
    }

    function fund() public payable {
        require(PriceConverter.convertETHtoUSD(msg.value) >= MINIMUM_USD , "You don't have enough ETH!");
        funders.push(msg.sender);
        howMuchFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        require(OWNER==msg.sender,"Unauthorized! You are not the OWNER of the contract");

        // resetting the mapping and array to zero
        for(uint i=0; i<funders.length; i++){
            howMuchFunded[funders[i]] = 0;
        }
        funders = new address[](0);
        // to send money we have 3 ways
        // transfer, send and call
        (bool sent,) = payable(OWNER).call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
    
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
