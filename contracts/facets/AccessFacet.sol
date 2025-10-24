// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IAccess} from "../interfaces/IAccess.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract AccessFacet is IAccess {
    // Role bit constants
    uint256 internal constant ROLE_UPGRADE = 1 << 0;
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    uint256 internal constant ROLE_INDEX = 1 << 2;
    uint256 internal constant ROLE_MONETARY = 1 << 3;

    modifier onlyOwnerOrRole(uint256 roleBit) {
        if(!_isOwner() && (GRCStorage.roles().roleBits[msg.sender] & roleBit) == 0) revert Errors.ErrMissingRole();
        _;
    }
    function _isOwner() internal view returns (bool) {
        return IERC173(address(this)).owner() == msg.sender; // delegatecall context
    }
    // Expose role constants (optional helper)
    function ROLE_UPGRADE_BIT() external pure returns (uint256) { return ROLE_UPGRADE; }
    function ROLE_GOVERNANCE_BIT() external pure returns (uint256) { return ROLE_GOVERNANCE; }
    function ROLE_INDEX_BIT() external pure returns (uint256) { return ROLE_INDEX; }
    function ROLE_MONETARY_BIT() external pure returns (uint256) { return ROLE_MONETARY; }

    function grantRoles(address account, uint256 roleBits) external onlyOwnerOrRole(ROLE_GOVERNANCE) {
        GRCStorage.roles().roleBits[account] |= roleBits; emit RoleGranted(account, roleBits);
    }
    function revokeRoles(address account, uint256 roleBits) external onlyOwnerOrRole(ROLE_GOVERNANCE) {
        GRCStorage.roles().roleBits[account] &= ~roleBits; emit RoleRevoked(account, roleBits);
    }
    function hasRoles(address account, uint256 roleBits) external view returns (bool) {
        return (GRCStorage.roles().roleBits[account] & roleBits) == roleBits;
    }
}
