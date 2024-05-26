// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MissingPeopleLog {
    // Structure to store information about a missing person
    struct MissingPerson {
        string name;
        string lastKnownLocation;
        string description;
    }

    // Mapping to store missing persons' information
    mapping(uint256 => MissingPerson) public missingPeople;

    uint256 public totalMissingPeople;

    // Event to log when a new person is added to the missing people list
    event PersonAdded(string name, string lastKnownLocation, string description);

    // Function to add a missing person to the log
    function addMissingPerson(string memory _name, string memory _lastKnownLocation, string memory _description) public {
        totalMissingPeople++;
        missingPeople[totalMissingPeople] = MissingPerson(_name, _lastKnownLocation, _description);
        emit PersonAdded(_name, _lastKnownLocation, _description);
    }
}