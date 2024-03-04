// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    struct UserInfo {
        address payable userAddress;
        string name;
        string email;
    }

    mapping(address => UserInfo) public users;

    function register(string memory _name, string memory _email) public {
        users[msg.sender] = UserInfo(payable(msg.sender), _name, _email);
    }
}
