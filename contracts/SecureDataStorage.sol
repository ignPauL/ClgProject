// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureDataStorage {
    address public owner;

    struct EncryptedData {
        string dataHash; // Hash of the encrypted data stored off-chain (e.g., IPFS hash)
        string metadata; // Additional metadata (e.g., description, timestamp)
        address uploader;
    }

    mapping(uint256 => EncryptedData) private dataRegistry;
    mapping(address => bool) private authorizedUsers;
    uint256 private dataCount;

    event DataRegistered(uint256 indexed dataId, address indexed uploader, string dataHash, string metadata);
    event AccessGranted(address indexed user);
    event AccessRevoked(address indexed user);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedUsers[msg.sender], "Only authorized users can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Grant access to a user
    function grantAccess(address _user) public onlyOwner {
        authorizedUsers[_user] = true;
        emit AccessGranted(_user);
    }

    // Revoke access from a user
    function revokeAccess(address _user) public onlyOwner {
        authorizedUsers[_user] = false;
        emit AccessRevoked(_user);
    }

    // Register encrypted data
    function registerData(string memory _dataHash, string memory _metadata) public onlyAuthorized {
        dataCount++;
        dataRegistry[dataCount] = EncryptedData({
            dataHash: _dataHash,
            metadata: _metadata,
            uploader: msg.sender
        });
        emit DataRegistered(dataCount, msg.sender, _dataHash, _metadata);
    }

    // Retrieve encrypted data
    function getData(uint256 _dataId) public view onlyAuthorized returns (string memory, string memory, address) {
        require(_dataId > 0 && _dataId <= dataCount, "Invalid data ID");
        EncryptedData storage data = dataRegistry[_dataId];
        return (data.dataHash, data.metadata, data.uploader);
    }

   
}
