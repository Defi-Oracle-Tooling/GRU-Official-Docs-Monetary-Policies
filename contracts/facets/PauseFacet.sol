// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IPause} from "../interfaces/IPause.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
import {IAccess} from "../interfaces/IAccess.sol";
contract PauseFacet is IPause {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier onlyGov() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    function setGlobalPause(bool paused) external onlyGov { GRCStorage.pause().global = paused; emit GlobalPaused(paused); }
    function setFunctionPause(bytes4 selector, bool paused) external onlyGov { GRCStorage.pause().func[selector] = paused; emit FunctionPaused(selector, paused); }
    function isPaused(bytes4 selector) external view returns (bool) { return GRCStorage.pause().func[selector]; }
    function isGlobalPaused() external view returns (bool) { return GRCStorage.pause().global; }
}
