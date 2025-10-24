// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IDiamondCut} from "./IDiamondCut.sol";
interface IGovernance {
    event CutProposed(bytes32 indexed id, address proposer, address init, bytes initData);
    event CutQueued(bytes32 indexed id, uint256 eta);
    event CutExecuted(bytes32 indexed id);
    event EmergencyBrake(bytes4 indexed selector, bool paused);
    function proposeCut(bytes32 id, IDiamondCut.FacetCut[] calldata cut, address init, bytes calldata initData) external;
    function queueCut(bytes32 id) external;
    function executeCut(bytes32 id) external;
    function emergencyBrake(bytes4 selector, bool pause) external;
    function timelock() external view returns (uint256);
    function quorumBps() external view returns (uint256);
    function eta(bytes32 id) external view returns (uint256);
    function proposer(bytes32 id) external view returns (address);
    function setGovernanceParams(uint256 timelockSeconds, uint256 quorumBps) external;
}
