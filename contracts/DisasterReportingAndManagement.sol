// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DisasterReportingAndManagement {
    // Structure to store information about a disaster report
    struct DisasterReport {
        string name;
        string location;
        uint256 timestamp;
        string description;
        bool isResolved;
        address[] stakeholders;
    }

    DisasterReport[] public disasterReports;
    uint256 public totalReports;

    // Event to log when a new disaster report is added
    event DisasterReportAdded(string name, string location, uint256 timestamp, string description);

    // Event to log when a disaster report is marked as resolved
    event DisasterReportResolved(uint256 reportId);

    // Function to add a new disaster report
    function addDisasterReport(
        string memory _name,
        string memory _location,
        uint256 _timestamp,
        string memory _description,
        address[] memory _stakeholders
    ) public {
        totalReports++;
        disasterReports.push(
            DisasterReport({
                name: _name,
                location: _location,
                timestamp: _timestamp,
                description: _description,
                isResolved: false,
                stakeholders: _stakeholders
            })
        );

        emit DisasterReportAdded(_name, _location, _timestamp, _description);
    }

    // Function to mark a disaster report as resolved
    function markReportAsResolved(uint256 _reportId) public {
        require(_reportId > 0 && _reportId <= totalReports, "Invalid report ID");
        disasterReports[_reportId - 1].isResolved = true;

        emit DisasterReportResolved(_reportId);
    }
}