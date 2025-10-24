// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IDiamondCut} from "../interfaces/IDiamondCut.sol";
contract ReenterInit {
    function init(address diamond) external {
        // Attempt recursive diamondCut (empty) to trigger reentrancy guard
        IDiamondCut.FacetCut[] memory cuts;
        IDiamondCut(diamond).diamondCut(cuts, address(0), "");
    }
}
