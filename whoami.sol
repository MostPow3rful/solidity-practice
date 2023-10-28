// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WhoAmI {
    function showAddress() public view returns(address yourAddress) {
        return msg.sender;
    }
}
