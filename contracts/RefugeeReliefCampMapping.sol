// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RefugeeReliefCampMapping {
    // Structure to store information about a refugee
    struct Refugee {
        string name;
        string location;
        uint256 campId;
    }

    // Structure to store information about a relief camp
    struct ReliefCamp {
        string name;
        string location;
        uint256 size; // Capacity of the camp
        uint256 currentOccupancy; // Number of refugees in the camp
    }

    Refugee[] public refugees;
    ReliefCamp[] public reliefCamps;
    uint256 public totalRefugees;
    uint256 public totalReliefCamps;

    // Event to log when a new refugee is added
    event RefugeeAdded(string name, string location, uint256 campId);

    // Event to log when a new relief camp is added
    event ReliefCampAdded(string name, string location, uint256 size);

    // Function to add a new refugee and assign them to a camp
    function addRefugee(string memory _name, string memory _location, uint256 _campId) public {
        require(_campId > 0 && _campId <= totalReliefCamps, "Invalid camp ID");
        totalRefugees++;
        refugees.push(Refugee(_name, _location, _campId));

        emit RefugeeAdded(_name, _location, _campId);
    }

    // Function to add a new relief camp
    function addReliefCamp(string memory _name, string memory _location, uint256 _size) public {
        totalReliefCamps++;
        reliefCamps.push(ReliefCamp(_name, _location, _size, 0));

        emit ReliefCampAdded(_name, _location, _size);
    }

    // Function to allocate a refugee to a camp
    function allocateRefugeeToCamp(uint256 _refugeeId, uint256 _campId) public {
        require(_refugeeId > 0 && _refugeeId <= totalRefugees, "Invalid refugee ID");
        require(_campId > 0 && _campId <= totalReliefCamps, "Invalid camp ID");

        refugees[_refugeeId - 1].campId = _campId;
        reliefCamps[_campId - 1].currentOccupancy++;

        emit RefugeeAdded(refugees[_refugeeId - 1].name, refugees[_refugeeId - 1].location, _campId);
    }
}