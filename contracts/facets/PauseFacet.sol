// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IPause} from "../interfaces/IPause.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract PauseFacet is IPause {
    function setGlobalPause(bool paused) external { GRCStorage.pause().global = paused; emit GlobalPaused(paused); }
    function setFunctionPause(bytes4 selector, bool paused) external { GRCStorage.pause().func[selector] = paused; emit FunctionPaused(selector, paused); }
    function isPaused(bytes4 selector) external view returns (bool) { return GRCStorage.pause().func[selector]; }
    function isGlobalPaused() external view returns (bool) { return GRCStorage.pause().global; }
}
