// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IGovernance} from "../interfaces/IGovernance.sol";
import {IDiamondCut} from "../interfaces/IDiamondCut.sol";
import {IAccess} from "../interfaces/IAccess.sol";
import {GRCStorage} from "../libraries/GRCStorage.sol";
import {Errors} from "../libraries/Errors.sol";
import {IERC173} from "../interfaces/IERC173.sol";

contract GovernanceFacet is IGovernance {
    uint256 internal constant ROLE_GOVERNANCE = 1 << 1;
    uint256 internal constant ROLE_UPGRADE = 1 << 0;
    modifier onlyGov() {
        if(!_isOwner() && (GRCStorage.roles().roleBits[msg.sender] & ROLE_GOVERNANCE) == 0) revert Errors.ErrGovernanceRole();
        _;
    }
    modifier onlyUpgrade() {
        if(!_isOwner() && (GRCStorage.roles().roleBits[msg.sender] & ROLE_UPGRADE) == 0) revert Errors.ErrUpgradeRole();
        _;
    }
    function _isOwner() internal view returns (bool) { return IERC173(address(this)).owner() == msg.sender; }

    function proposeCut(bytes32 id, IDiamondCut.FacetCut[] calldata cut, address init, bytes calldata initData) external onlyGov {
        GRCStorage.GovernanceState storage gs = GRCStorage.governance();
    if(gs.eta[id] != 0) revert Errors.ErrProposalExists();
        // encode cut array
        gs.encodedCut[id] = abi.encode(cut);
        gs.initAddr[id] = init;
        gs.initData[id] = initData;
        gs.proposer[id] = msg.sender;
        emit CutProposed(id, msg.sender, init, initData);
    }
    function queueCut(bytes32 id) external onlyGov {
        GRCStorage.GovernanceState storage gs = GRCStorage.governance();
    if(gs.eta[id] != 0) revert Errors.ErrProposalUsed();
    // a proposal must have encodedCut present
    if(gs.encodedCut[id].length == 0) revert Errors.ErrNoProposal();
        uint256 etaTime = block.timestamp + gs.timelockSeconds;
        gs.eta[id] = etaTime;
        emit CutQueued(id, etaTime);
    }
    function executeCut(bytes32 id) external onlyUpgrade {
        GRCStorage.GovernanceState storage gs = GRCStorage.governance();
        uint256 etaTime = gs.eta[id];
    if(etaTime == 0 || block.timestamp < etaTime) revert Errors.ErrNotReady();
        // decode cuts
        IDiamondCut.FacetCut[] memory cuts = abi.decode(gs.encodedCut[id], (IDiamondCut.FacetCut[]));
        address init = gs.initAddr[id];
        bytes memory initData = gs.initData[id];
        // call diamondCut on diamond (address(this))
        IDiamondCut(address(this)).diamondCut(cuts, init, initData);
        // cleanup
        delete gs.eta[id]; delete gs.encodedCut[id]; delete gs.initAddr[id]; delete gs.initData[id]; delete gs.proposer[id];
        emit CutExecuted(id);
    }
    function emergencyBrake(bytes4 selector, bool pause) external onlyGov {
        // integrate with Pause storage
        GRCStorage.PauseState storage ps = GRCStorage.pause();
        ps.func[selector] = pause;
        emit EmergencyBrake(selector, pause);
    }
    function timelock() external view returns (uint256) { return GRCStorage.governance().timelockSeconds; }
    function quorumBps() external view returns (uint256) { return GRCStorage.governance().quorumBps; }
    function eta(bytes32 id) external view returns (uint256) { return GRCStorage.governance().eta[id]; }
    function proposer(bytes32 id) external view returns (address) { return GRCStorage.governance().proposer[id]; }
    function setGovernanceParams(uint256 timelockSeconds, uint256 quorumBps) external onlyGov {
        GRCStorage.GovernanceState storage gs = GRCStorage.governance();
        gs.timelockSeconds = timelockSeconds;
        gs.quorumBps = quorumBps;
    }
}
