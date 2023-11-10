// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// [ Imported Contracts ]
import "error.sol";

contract Management is Error {
    // [ Structure ]
    // This Structure Have 3 Fields : [firstName string], [lastName string], [age uint8] Also every address have one account
    struct Account {
        string firstName;
        string lastName;
        uint8 age;
    }

    // [ Modifiers ]
    modifier accountIsExists() {
        if (haveAccount[msg.sender] == false) {
            revert accountStatus(
                false,
                "[ You CanNot Do this Action beacuse You DoNot Have an Account. Please Create Account ]"
            );
        }
        _;
    }

    modifier accountIsNotExists() {
        if (haveAccount[msg.sender] == true) {
            revert accountStatus(
                true,
                "[ You CanNot Do this Action beacuse You Have an Account. Please Reset Your Account ]"
            );
        }
        _;
    }

    // [ Events ]
    event AccountCreated(string firstName, string lastName, uint8 age);
    event AccountUpdated(string firstName, string lastName, uint8 age);
    event AccountReseted(address owner);

    // [ Maps ]
    mapping(address => Account) private database;
    mapping(address => bool) private haveAccount;

    // [ Functions ]
    // This Function Create New Account
    function createAccount(
        string memory _firstname,
        string memory _lastName,
        uint8 _age
    ) public accountIsNotExists {
        database[msg.sender] = Account(_firstname, _lastName, _age);
        haveAccount[msg.sender] = true;
        emit AccountCreated(_firstname, _lastName, _age);
    }

    // This Function Update Account Information
    function updateAccount(
        string memory _firstName,
        string memory _lastName,
        uint8 _age
    ) public accountIsExists {
        Account memory temp = Account("", "", 0);

        // If-Else Statements
        keccak256(abi.encodePacked(_firstName)) !=
            keccak256(abi.encodePacked(""))
            ? temp.firstName = _firstName
            : temp.firstName = database[msg.sender].firstName;

        keccak256(abi.encodePacked(_lastName)) !=
            keccak256(abi.encodePacked(""))
            ? temp.lastName = _lastName
            : temp.lastName = database[msg.sender].lastName;

        _age != database[msg.sender].age
            ? temp.age = _age
            : temp.age = database[msg.sender].age;

        database[msg.sender] = temp;
        emit AccountUpdated(_firstName, _lastName, _age);
    }

    // This Function Reset Account Information
    function resetPerson() public accountIsExists {
        database[msg.sender] = Account("", "", 0);
        haveAccount[msg.sender] = false;
        emit AccountReseted(msg.sender);
    }

    // This Function Return The FirstName Field of Account
    function showFirstName()
        public
        view
        accountIsExists
        returns (string memory firstName)
    {
        return database[msg.sender].firstName;
    }

    // This Function Return The LastName Field Of Account
    function showLastName()
        public
        view
        accountIsExists
        returns (string memory lastName)
    {
        return database[msg.sender].lastName;
    }

    // This Function Return The Age Field Of Account
    function showAge() public view accountIsExists returns (uint8 age) {
        return database[msg.sender].age;
    }

    // This Function Return The address Of User/Contract
    function showAddress() public view returns (address) {
        return msg.sender;
    }

    // This Function Show the Amount of User/Contract
    function showAmount() public view returns (uint256) {
        return msg.sender.balance;
    }
}
