// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bet.sol";

contract Admin is Bet {
    address public admin;

    constructor(address _adminAddress, address _matchAddress, uint256 _entryFee)
        Bet(_matchAddress, _entryFee) {
        admin = _adminAddress;
    }

}
