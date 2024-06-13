// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AcademicCredentials {
    struct Credential {
        address institution;
        string studentName;
        string courseName;
        uint256 issueDate;
        bool isRevoked;
    }

    address public owner;
    mapping(address => bool) public authorizedInstitutions;
    mapping(bytes32 => Credential) public credentials;
    mapping(bytes32 => bool) public credentialExists;

    event CredentialIssued(bytes32 indexed credentialId, address indexed institution, string studentName, string courseName, uint256 issueDate);
    event CredentialRevoked(bytes32 indexed credentialId, address indexed institution);
    event InstitutionAuthorized(address indexed institution);
    event InstitutionDeauthorized(address indexed institution);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyAuthorizedInstitution() {
        require(authorizedInstitutions[msg.sender], "Only authorized institution can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function authorizeInstitution(address institution) external onlyOwner {
        authorizedInstitutions[institution] = true;
        emit InstitutionAuthorized(institution);
    }

    function deauthorizeInstitution(address institution) external onlyOwner {
        authorizedInstitutions[institution] = false;
        emit InstitutionDeauthorized(institution);
    }

    function issueCredential(address student, string calldata studentName, string calldata courseName) external onlyAuthorizedInstitution {
        bytes32 credentialId = keccak256(abi.encodePacked(student, studentName, courseName, block.timestamp));
        require(!credentialExists[credentialId], "Credential already exists");

        credentials[credentialId] = Credential({
            institution: msg.sender,
            studentName: studentName,
            courseName: courseName,
            issueDate: block.timestamp,
            isRevoked: false
        });
        credentialExists[credentialId] = true;

        emit CredentialIssued(credentialId, msg.sender, studentName, courseName, block.timestamp);
    }

    function revokeCredential(bytes32 credentialId) external onlyAuthorizedInstitution {
        require(credentialExists[credentialId], "Credential does not exist");
        Credential storage credential = credentials[credentialId];
        require(credential.institution == msg.sender, "Only issuing institution can revoke");

        credential.isRevoked = true;
        emit CredentialRevoked(credentialId, msg.sender);
    }

    function verifyCredential(bytes32 credentialId) external view returns (bool valid, address institution, string memory studentName, string memory courseName, uint256 issueDate) {
        require(credentialExists[credentialId], "Credential does not exist");
        Credential memory credential = credentials[credentialId];
        return (!credential.isRevoked, credential.institution, credential.studentName, credential.courseName, credential.issueDate);
    }
}
