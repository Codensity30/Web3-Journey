// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract SimpleStorage{
    // custom data type to represent person
    struct PersonFavNum{
        uint favNum;
        string name;
    }

    // these both are public varaibles hence could be visible without spending gas
    PersonFavNum[] public person; // array to hold the person data
    mapping (string => uint) public nameToFav; // map the person name with favNum

    // function to add the person information
    // since this function modifies the blockchain hence gas is spent
    function addPerson(uint _favNum, string memory _name) public {
        person.push(PersonFavNum({favNum:_favNum,name:_name}));
        nameToFav[_name] = _favNum;
    }
}