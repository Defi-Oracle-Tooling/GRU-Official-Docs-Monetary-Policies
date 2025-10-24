// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {ITriangulation} from "../interfaces/ITriangulation.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract TriangulationFacet is ITriangulation {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier onlyGov() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    function setRate(bytes32 fromAsset, bytes32 toAsset, uint256 rate) external onlyGov {
        if(rate == 0) revert Errors.ErrRateUnset();
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        ts.rate[fromAsset][toAsset] = rate;
        emit RateSet(fromAsset, toAsset, rate);
    }
    function getRate(bytes32 fromAsset, bytes32 toAsset) external view returns (uint256 rate) {
        rate = GRCStorage.triangulation().rate[fromAsset][toAsset];
    }
    function triangulate(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external returns (uint256 outAmount) {
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        uint256 rate = ts.rate[fromAsset][toAsset];
        if(rate == 0) revert Errors.ErrRateUnset();
        outAmount = amount * rate / 1e18;
        uint256 fee = outAmount * ts.feeBps / 10000;
        outAmount -= fee;
        emit Triangulated(fromAsset, toAsset, amount, outAmount);
    }
    function redeem(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external returns (uint256 outAmount) {
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        uint256 rate = ts.rate[fromAsset][toAsset];
        if(rate == 0) revert Errors.ErrRateUnset();
        outAmount = amount * rate / 1e18;
        uint256 fee = outAmount * ts.feeBps / 10000;
        outAmount -= fee;
        emit Redeemed(fromAsset, toAsset, amount, outAmount);
    }
    function setFees(uint256 feeBps_) external onlyGov {
        if(feeBps_ > 450) revert Errors.ErrFeeTooHigh();
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        emit FeeUpdated(ts.feeBps, feeBps_);
        ts.feeBps = feeBps_;
    }
    function feeBps() external view returns (uint256) { return GRCStorage.triangulation().feeBps; }
}
