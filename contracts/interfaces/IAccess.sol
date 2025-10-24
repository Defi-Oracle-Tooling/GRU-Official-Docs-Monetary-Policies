// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IAccess {
    event RoleGranted(address indexed account, uint256 roleBits);
    event RoleRevoked(address indexed account, uint256 roleBits);
    function grantRoles(address account, uint256 roleBits) external;
    function revokeRoles(address account, uint256 roleBits) external;
    function hasRoles(address account, uint256 roleBits) external view returns (bool);
    function ROLE_UPGRADE_BIT() external pure returns (uint256);
    function ROLE_GOVERNANCE_BIT() external pure returns (uint256);
    function ROLE_INDEX_BIT() external pure returns (uint256);
    function ROLE_MONETARY_BIT() external pure returns (uint256);
}