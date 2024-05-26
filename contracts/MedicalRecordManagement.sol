// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MedicalRecordManagement {
    // Structure to store medical records
    struct MedicalRecord {
        string name;
        string addres;
        string dataHash; // Hash of the actual medical data
    }

    // Mapping to store medical records
    mapping(uint256 => MedicalRecord) public medicalRecords;

    uint256 public totalMedicalRecords;

    // Event to log when a new medical record is added
    event MedicalRecordAdded(string name, string addres, string dataHash);

    // Function to add a medical record to the system
    function addMedicalRecord(string memory _name, string memory _addres, string memory _dataHash) public {
        totalMedicalRecords++;
        medicalRecords[totalMedicalRecords] = MedicalRecord(_name, _addres, _dataHash);
        emit MedicalRecordAdded(_name, _addres, _dataHash);
    }
}