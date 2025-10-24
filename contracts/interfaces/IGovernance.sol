// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IDiamondCut} from "./IDiamondCut.sol";
interface IGovernance {
    event CutProposed(bytes32 id, address proposer);
    event CutQueued(bytes32 id, uint256 eta);
    event CutExecuted(bytes32 id);
    event EmergencyBrake(bytes4 selector, bool paused);
    function proposeCut(bytes32 id, IDiamondCut.FacetCut[] calldata cut) external;
    function queueCut(bytes32 id) external;
    function executeCut(bytes32 id) external;
    function emergencyBrake(bytes4 selector, bool pause) external;
    function timelock() external view returns (uint256);
    function quorumBps() external view returns (uint256);
}
