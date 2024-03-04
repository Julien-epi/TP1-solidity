// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";

interface IUser {
    function getUserInfo(address _userAddress) external view returns (address payable, string memory, string memory);
}

contract Match {
    struct MatchInfo {
        uint256 id;
        string homeTeam;
        string awayTeam;
        uint256 homeTeamScore;
        uint256 awayTeamScore;
        bool isResultAnnounced;
    }

    mapping(uint256 => MatchInfo) public matches;

    function createMatch(
        uint256 _matchId,
        string memory _homeTeam,
        string memory _awayTeam
    ) public {
        matches[_matchId] = MatchInfo(_matchId, _homeTeam, _awayTeam, 0, 0, false);
    }

    function setMatchResult(
        uint256 _matchId,
        uint256 _homeTeamScore,
        uint256 _awayTeamScore
    ) public {
        MatchInfo storage matchInfo = matches[_matchId];
        matchInfo.homeTeamScore = _homeTeamScore;
        matchInfo.awayTeamScore = _awayTeamScore;
        matchInfo.isResultAnnounced = true;
    }

    function getMatchInfo(uint256 _matchId) public view returns (uint256, string memory, string memory, uint256, uint256, bool) {
        MatchInfo memory matchInfo = matches[_matchId];
        return (
            matchInfo.id,
            matchInfo.homeTeam,
            matchInfo.awayTeam,
            matchInfo.homeTeamScore,
            matchInfo.awayTeamScore,
            matchInfo.isResultAnnounced
        );
    }
}
