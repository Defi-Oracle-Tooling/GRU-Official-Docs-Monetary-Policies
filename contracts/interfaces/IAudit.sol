// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IAudit {
    event PoRPosted(uint64 period, bytes32 root, string ipfsRef);
    event PoRSealed(uint64 period);
    function postPoR(uint64 period, bytes32 merkleRoot, string calldata ipfsRef) external;
    function seal(uint64 period) external;
    function getPoR(uint64 period) external view returns (bytes32 merkleRoot, string memory ipfsRef, bool isSealed);
}