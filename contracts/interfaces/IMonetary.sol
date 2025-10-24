// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IMonetary {
    event ScalarUpdated(uint256 oldScalar, uint256 newScalar);
    function mintM1(address to, uint256 amount) external;
    function burnM1(address from, uint256 amount) external;
    function issueM0(address to, uint256 amount) external;
    function redeemM0(address from, uint256 amount) external;
    function setScalarS(uint256 newScalar) external;
    function getLayers() external view returns (uint256 m00, uint256 m0, uint256 m1);
}