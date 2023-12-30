// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "contracts/SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    function setFavNum(uint _favNum) public override {
        favNum = _favNum + 5;
    }
}