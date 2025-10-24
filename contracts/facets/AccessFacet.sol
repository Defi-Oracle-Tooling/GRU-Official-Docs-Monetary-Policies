// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IAccess} from "../interfaces/IAccess.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract AccessFacet is IAccess {
    function grantRoles(address account, uint256 roleBits) external { GRCStorage.roles().roleBits[account] |= roleBits; emit RoleGranted(account, roleBits); }
    function revokeRoles(address account, uint256 roleBits) external { GRCStorage.roles().roleBits[account] &= ~roleBits; emit RoleRevoked(account, roleBits); }
    function hasRoles(address account, uint256 roleBits) external view returns (bool) { return (GRCStorage.roles().roleBits[account] & roleBits) == roleBits; }
}
