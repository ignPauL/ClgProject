// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CriticalAreaManagement {
    // Structure to store information about a critical area
    struct CriticalArea {
        string name;
        string description;
        uint8 severity; // Severity can be on a scale of 1 to 10
    }

    // Mapping to store critical areas
    mapping(uint256 => CriticalArea) public criticalAreas;
    uint256 public totalCriticalAreas;

    // Event to log when a new critical area is added
    event CriticalAreaAdded(string name, string description, uint8 severity);

    // Event to log when a critical area is removed
    event CriticalAreaRemoved(uint256 areaId);

    // Function to add a new critical area
    function addCriticalArea(string memory _name, string memory _description, uint8 _severity) public {
        totalCriticalAreas++;
        criticalAreas[totalCriticalAreas] = CriticalArea(_name, _description, _severity);

        emit CriticalAreaAdded(_name, _description, _severity);
    }

    // Function to remove a critical area
    function removeCriticalArea(uint256 _areaId) public {
        require(_areaId > 0 && _areaId <= totalCriticalAreas, "Invalid area ID");

        delete criticalAreas[_areaId];

        emit CriticalAreaRemoved(_areaId);
    }
}