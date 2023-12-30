// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "contracts/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    // deploying contracts from here
    function createSimpleStorage() public {
        simpleStorageArray.push(new SimpleStorage());
    }

    // adding person to simple storage contaract using the addPerson method defined at SimpleStorage contract
    function addPersonToSimpStore(uint index, uint favNum, string memory name) public {
        simpleStorageArray[index].addPerson(favNum,name);
    }

    // method to get the person fav number stored at particular contract
    function getPersons(uint index, string memory name) public view returns (uint) {
        return simpleStorageArray[index].nameToFav(name);
    }
}
