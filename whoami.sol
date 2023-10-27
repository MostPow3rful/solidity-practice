// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhoAmI {
    // [ Structure ]
    // This Structure Have 3 Fields : [firstName string], [lastName string], [age uint8] Also every address have one account
    struct Account {
        string firstName;
        string lastName;
        uint8 age;
    }

    // [ Events ]
    event AccountCreated(string firstName, string lastName, uint8 age);
    event AccountUpdated(string firstName, string lastName, uint8 age);
    event AccountReseted(address owner);

    // [ Maps ]
    mapping(address => Account) private database;
    mapping(address => bool) private haveAccount;

    // [ Functions ]
    // This Function Show The Address of Wallet/Smart Contract  
    function myAddress() public view returns(address) {
        return msg.sender;
    }

    // This Function Create New Account
    function createAccount(
        string memory _firstname,
        string memory _lastName,
        uint8 _age
    ) public {
        database[msg.sender] = Account(_firstname, _lastName, _age);
        haveAccount[msg.sender] = true;
        emit AccountCreated(_firstname, _lastName, _age);
    }

    // This Function Update Account Information
    function updateAccount(
        string memory _firstName,
        string memory _lastName,
        uint8 _age
    ) public {
        // Check : is Account Exists or Not
        require(haveAccount[msg.sender] == true, "[ You Don't Have Any Account To Update, Please Create One ]");
        Account memory temp = Account("","",0);

        // If-Else Statement
        keccak256(abi.encodePacked(_firstName)) != keccak256(abi.encodePacked("")) ? temp.firstName = _firstName : temp.firstName = database[msg.sender].firstName;
        keccak256(abi.encodePacked(_lastName)) != keccak256(abi.encodePacked("")) ? temp.lastName = _lastName : temp.lastName = database[msg.sender].   ;
        _age != database[msg.sender].age ? temp.age = _age : temp.age = database[msg.sender].age;

        database[msg.sender] = temp;
        emit AccountUpdated(_firstName, _lastName, _age);
    }

    // This Function Reset Account Information
    function resetPerson() public {
        database[msg.sender] = Account("","",0);
        haveAccount[msg.sender] = false;
        emit AccountReseted(msg.sender);
    }

    // This Function Return The FirstName Field of Account
    function showFirstName() public view returns(string memory firstName) {
        return database[msg.sender].firstName;
    }

    // This Function Return The LastName Field Of Account
    function showLastName() public view returns(string memory lastName) {
        return database[msg.sender].lastName;
    }

    // This Function Return The Age Field Of Account
    function showAge() public view returns(uint8 age) {
        return database[msg.sender].age;
    }

}
