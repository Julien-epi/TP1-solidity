// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";
import "./Match.sol";

interface IMatchContract {
    function getMatchInfo(uint256 _matchId) external view returns (uint256, string memory, string memory, uint256, uint256, bool);
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }
}

contract Bet {
    using SafeMath for uint256;

    IMatchContract public matchContract;
    uint256 public entryFee;
    mapping(address => mapping(uint256 => BetInfo[])) public userBets;
    mapping(uint256 => MappingBetInfo) private matchBets;

    struct BetInfo {
        uint256 matchId;
        uint256 homeTeamScore;
        uint256 awayTeamScore;
    }

    struct MappingBetInfo {
        mapping(address => BetInfo[]) userBets;
    }

    constructor(address _matchAddress, uint256 _entryFee) {
        matchContract = IMatchContract(_matchAddress);
        entryFee = _entryFee;
    }

    function betOnMatch(
        uint256 _matchId,
        uint256 _homeTeamScore,
        uint256 _awayTeamScore
    ) public payable {
        require(msg.value == entryFee, "Bet amount must be equal to the entry fee");

        (,,,uint256 homeTeamScore, uint256 awayTeamScore, bool isResultAnnounced) = matchContract.getMatchInfo(_matchId);
        require(!isResultAnnounced, "Match result has already been announced");
        require(homeTeamScore == 0 && awayTeamScore == 0, "Match result has already been set");

        BetInfo memory newBet = BetInfo(_matchId, _homeTeamScore, _awayTeamScore);
        userBets[msg.sender][_matchId].push(newBet);
        matchBets[_matchId].userBets[msg.sender].push(newBet);
    }
}
