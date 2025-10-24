// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IPause {
    event GlobalPaused(bool paused);
    event FunctionPaused(bytes4 selector, bool paused);
    function setGlobalPause(bool paused) external;
    function setFunctionPause(bytes4 selector, bool paused) external;
    function isPaused(bytes4 selector) external view returns (bool);
    function isGlobalPaused() external view returns (bool);
}