// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AidPackageDistribution {
    // Structure to store information about an aid package
    struct AidPackage {
        address sender;
        string recipient;
        string packageDetails;
        string sourceLocation;
        string destinationLocation;
        bool delivered;
    }

    // Mapping to store aid packages
    mapping(uint256 => AidPackage) public aidPackages;

    uint256 public totalAidPackages;

    // Event to log when a new aid package is created
    event AidPackageCreated(
        address sender,
        string recipient,
        string packageDetails,
        string sourceLocation,
        string destinationLocation
    );

    // Event to log when an aid package is marked as delivered
    event AidPackageDelivered(uint256 packageId);

    // Function to create a new aid package
    function createAidPackage(
        string memory _recipient,
        string memory _packageDetails,
        string memory _sourceLocation,
        string memory _destinationLocation
    ) public {
        totalAidPackages++;
        aidPackages[totalAidPackages] = AidPackage(
            msg.sender,
            _recipient,
            _packageDetails,
            _sourceLocation,
            _destinationLocation,
            false
        );

        emit AidPackageCreated(msg.sender, _recipient, _packageDetails, _sourceLocation, _destinationLocation);
    }

    // Function to mark an aid package as delivered
    function markAidPackageDelivered(uint256 _packageId) public {
        require(_packageId > 0 && _packageId <= totalAidPackages, "Invalid package ID");
        require(aidPackages[_packageId].sender == msg.sender, "Only the sender can mark as delivered");

        aidPackages[_packageId].delivered = true;

        emit AidPackageDelivered(_packageId);
    }
}