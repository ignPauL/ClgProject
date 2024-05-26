// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoCurrencyAidDistribution {
    address public organization;
    mapping(address => uint256) public recipients;
    uint256 public totalRecipients;

    event RecipientAdded(address indexed recipient, uint256 amount);
    event AidDistributed(address indexed recipient, uint256 amount);
    event FundsDeposited(address indexed from, uint256 amount);

    modifier onlyOrganization() {
        require(msg.sender == organization, "Only the organization can perform this action");
        _;
    }

    constructor() {
        organization = msg.sender;
    }

    // Function to add a recipient and specify the amount of aid
    function addRecipient(address _recipient, uint256 _amount) public onlyOrganization {
        require(_recipient != address(0), "Invalid recipient address");
        require(_amount > 0, "Aid amount must be greater than zero");
        require(recipients[_recipient] == 0, "Recipient already added");

        recipients[_recipient] = _amount;
        totalRecipients++;
        emit RecipientAdded(_recipient, _amount);
    }

    // Function to distribute aid to all recipients
    function distributeAid() public onlyOrganization {
        for (uint256 i = 0; i < totalRecipients; i++) {
            address recipient = address(uint160(uint256(keccak256(abi.encodePacked(i)))));
            uint256 amount = recipients[recipient];

            if (amount > 0) {
                recipients[recipient] = 0;
                payable(recipient).transfer(amount);
                emit AidDistributed(recipient, amount);
            }
        }
    }

    // Function to deposit funds into the contract
    function depositFunds() public payable onlyOrganization {
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to get the aid amount for a specific recipient
    function getAidAmount(address _recipient) public view returns (uint256) {
        return recipients[_recipient];
    }
    
    // Function to withdraw remaining funds by the organization
    function withdrawFunds(uint256 _amount) public onlyOrganization {
        require(_amount <= address(this).balance, "Insufficient contract balance");
        payable(organization).transfer(_amount);
    }
}
