// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IDiamondLoupe {
    function facets() external view returns (address[] memory facetAddresses, bytes4[][] memory selectors);
    function facetFunctionSelectors(address facet) external view returns (bytes4[] memory);
    function facetAddresses() external view returns (address[] memory);
    function facetAddress(bytes4 selector) external view returns (address);
}