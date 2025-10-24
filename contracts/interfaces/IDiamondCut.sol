// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IDiamondCut {
    enum FacetCutAction {Add, Replace, Remove}
    struct FacetCut { address facetAddress; FacetCutAction action; bytes4[] functionSelectors; }
    event DiamondCut(FacetCut[] _cut, address _init, bytes _calldata);
    function diamondCut(FacetCut[] calldata _cut, address _init, bytes calldata _calldata) external;
}