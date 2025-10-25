// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {ITriangulation} from "../interfaces/ITriangulation.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";
contract TriangulationFacet is ITriangulation {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    modifier nonReentrant() {
        GRCStorage.Reentrancy storage rs = GRCStorage.reentrancy();
        if(rs.entered == 1) revert Errors.ErrReentrancy();
        rs.entered = 1; _; rs.entered = 0;
    }
    modifier onlyGov() {
        if(IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    // Sets a forward rate (fromAsset -> toAsset) scaled by 1e18 and auto-stores the inverse (toAsset -> fromAsset).
    // If rate = 2e18 (2 toAsset per 1 fromAsset), inverse becomes 0.5e18 via 1e36 / rate to preserve 1e18 scaling.
    function setRate(bytes32 fromAsset, bytes32 toAsset, uint256 rate) external onlyGov nonReentrant {
        if(rate == 0) revert Errors.ErrRateUnset();
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        ts.rate[fromAsset][toAsset] = rate;
        emit RateSet(fromAsset, toAsset, rate);
        // compute and store inverse
        uint256 inverse = (1e36 / rate); // (1e18 * 1e18) / rate keeps 1e18 scaling
        ts.rate[toAsset][fromAsset] = inverse;
        emit RateSet(toAsset, fromAsset, inverse);
    }
    function getRate(bytes32 fromAsset, bytes32 toAsset) external view returns (uint256 rate) {
        rate = GRCStorage.triangulation().rate[fromAsset][toAsset];
    }
    function triangulate(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external nonReentrant returns (uint256 outAmount) {
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        uint256 rate = ts.rate[fromAsset][toAsset];
        if(rate == 0) revert Errors.ErrRateUnset();
        outAmount = amount * rate / 1e18;
        uint256 fee = outAmount * ts.feeBps / 10000;
        outAmount -= fee;
        emit Triangulated(fromAsset, toAsset, amount, outAmount);
    }
    function redeem(bytes32 fromAsset, bytes32 toAsset, uint256 amount) external nonReentrant returns (uint256 outAmount) {
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        uint256 rate = ts.rate[fromAsset][toAsset];
        if(rate == 0) revert Errors.ErrRateUnset();
        outAmount = amount * rate / 1e18;
        uint256 fee = outAmount * ts.feeBps / 10000;
        outAmount -= fee;
        emit Redeemed(fromAsset, toAsset, amount, outAmount);
    }
    function setFees(uint256 feeBps_) external onlyGov nonReentrant {
        if(feeBps_ > 450) revert Errors.ErrFeeTooHigh();
        GRCStorage.TriangulationState storage ts = GRCStorage.triangulation();
        emit FeeUpdated(ts.feeBps, feeBps_);
        ts.feeBps = feeBps_;
    }
    function feeBps() external view returns (uint256) { return GRCStorage.triangulation().feeBps; }
}
