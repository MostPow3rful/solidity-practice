// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Error {
    // [ Errors ]
    error accountStatus(bool _haveAccount, string _message);
    
    // [ Events ]
    event ErrorTryingToCreateAccount(address owner);
    event ErrorTryingToResetAccount(address owner);
}
