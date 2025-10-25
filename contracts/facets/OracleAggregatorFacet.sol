// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";

/// @title OracleAggregatorFacet (stub)
/// @notice Provides multi-source price feed registration & median aggregation (planned).
/// @dev Initial version stores no data; all mutating calls revert ErrNotReady().
contract OracleAggregatorFacet {
    uint256 internal constant ROLE_ORACLE_AGG = 1 << 5;

    struct FeedRecord { uint256 price; uint64 timestamp; uint16 confidenceBps; bool active; }

    modifier onlyOracleAgg() {
        if (IERC173(address(this)).owner() != msg.sender && (GRCStorage.roles().roleBits[msg.sender] & ROLE_ORACLE_AGG) == 0) {
            revert Errors.ErrMissingRole();
        }
        _;
    }

    /// @notice Register a new feed for an asset (stub).
    function registerFeed(bytes32 assetId, address feedAddress) external onlyOracleAgg {
        assetId; feedAddress;
        revert Errors.ErrNotReady();
    }

    /// @notice Update a feed reading (stub).
    function pushPrice(bytes32 assetId, address feedAddress, uint256 price, uint64 ts, uint16 confidenceBps) external onlyOracleAgg {
        assetId; feedAddress; price; ts; confidenceBps;
        revert Errors.ErrNotReady();
    }

    /// @notice Get aggregated (median) price for asset.
    /// @dev Returns zeroed struct since aggregation not implemented yet.
    function medianPrice(bytes32 assetId) external view returns (uint256 price, uint16 confidenceBps, uint64 timestamp) {
        assetId; // silence warning
        return (0, 0, 0); // placeholder
    }
}
