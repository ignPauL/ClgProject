// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartInsurance {
    address public insurer;
    uint256 public policyCount = 0;

    struct Policy {
        uint256 policyId;
        address policyHolder;
        uint256 premium;
        uint256 payout;
        bool isActive;
        bool isClaimed;
    }

    struct DamageAssessment {
        uint256 policyId;
        uint256 damageAmount;
        bool isAssessed;
        bool isApproved;
    }

    mapping(uint256 => Policy) public policies;
    mapping(uint256 => DamageAssessment) public assessments;

    event PolicyCreated(uint256 policyId, address policyHolder, uint256 premium, uint256 payout);
    event ClaimSubmitted(uint256 policyId, uint256 damageAmount);
    event ClaimApproved(uint256 policyId, uint256 payoutAmount);
    event ClaimRejected(uint256 policyId);

    modifier onlyInsurer() {
        require(msg.sender == insurer, "Only the insurer can perform this action");
        _;
    }

    modifier onlyPolicyHolder(uint256 _policyId) {
        require(msg.sender == policies[_policyId].policyHolder, "Only the policy holder can perform this action");
        _;
    }

    constructor() {
        insurer = msg.sender;
    }

    function createPolicy(address _policyHolder, uint256 _premium, uint256 _payout) public onlyInsurer {
        policyCount++;
        policies[policyCount] = Policy(policyCount, _policyHolder, _premium, _payout, true, false);
        emit PolicyCreated(policyCount, _policyHolder, _premium, _payout);
    }

    function submitClaim(uint256 _policyId, uint256 _damageAmount) public onlyPolicyHolder(_policyId) {
        require(policies[_policyId].isActive, "Policy is not active");
        require(!policies[_policyId].isClaimed, "Claim already submitted");

        assessments[_policyId] = DamageAssessment(_policyId, _damageAmount, false, false);
        emit ClaimSubmitted(_policyId, _damageAmount);
    }

    function assessClaim(uint256 _policyId, bool _isApproved) public onlyInsurer {
        require(assessments[_policyId].isAssessed == false, "Claim already assessed");
        require(policies[_policyId].isActive, "Policy is not active");

        assessments[_policyId].isAssessed = true;
        assessments[_policyId].isApproved = _isApproved;

        if (_isApproved) {
            policies[_policyId].isClaimed = true;
            policies[_policyId].isActive = false;
            payable(policies[_policyId].policyHolder).transfer(policies[_policyId].payout);
            emit ClaimApproved(_policyId, policies[_policyId].payout);
        } else {
            emit ClaimRejected(_policyId);
        }
    }

    function fundContract() public payable onlyInsurer {}

    function getPolicyDetails(uint256 _policyId) public view returns (Policy memory) {
        return policies[_policyId];
    }

    function getAssessmentDetails(uint256 _policyId) public view returns (DamageAssessment memory) {
        return assessments[_policyId];
    }
}
