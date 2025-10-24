// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IMonetary} from "../interfaces/IMonetary.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
contract MonetaryFacet is IMonetary {
    modifier onlyScalarManager() { /* placeholder for role check */ _; }
    function mintM1(address to, uint256 amount) external { to; amount; revert("NOT_IMPL"); }
    function burnM1(address from, uint256 amount) external { from; amount; revert("NOT_IMPL"); }
    function issueM0(address to, uint256 amount) external { to; amount; revert("NOT_IMPL"); }
    function redeemM0(address from, uint256 amount) external { from; amount; revert("NOT_IMPL"); }
    function setScalarS(uint256 newScalar) external onlyScalarManager {
        GRCStorage.MonetaryState storage ms = GRCStorage.monetary();
        emit ScalarUpdated(ms.scalarS, newScalar);
        ms.scalarS = newScalar;
    }
    function getLayers() external view returns (uint256 m00, uint256 m0, uint256 m1) {
        GRCStorage.MonetaryState storage ms = GRCStorage.monetary();
        return (ms.m00, ms.m0, ms.m1);
    }
}
