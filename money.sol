// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReceiveETH {
    // Amount Of Contract
    uint private amount;

    // Used Constructor To Set Amount of Contract When it Starts to work
    constructor() {
        amount = address(this).balance;
    }

    // [ Modifiers ]
    // This Modifier Check How Many ETHs Received And Emit an event 
    modifier updateAmount() {
        _;
        emit receivedETH((address(this).balance - amount) / (10 ** 18));
        amount = address(this).balance;
    }

    // [ Events ]
    // This Event Show The Value of  Received ETHs
    event receivedETH(uint value);

    // [ Receivers ]
    receive() external payable updateAmount {}
    fallback() external payable updateAmount {}

    // [ Functions ]
    // This Function Show The Balance of Contract
    function contractBalance() external view returns (uint) {
        return address(this).balance;
    }

    // This Function Show The Balance Of Wallet
    function walletBalance() external view returns (uint) {
        return msg.sender.balance;
    }
}

contract SendETH {
    // [ Functions ]
    // This Function Send Custom Value of ETHs to Receiver Address
    function send(address _to) external payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(
            success,
            "[ Money DidNot Transfer From Your Wallet. Plz Try Again ]"
        );
    }
}
