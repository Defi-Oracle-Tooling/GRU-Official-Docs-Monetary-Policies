// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import {IDiamondCut} from "./interfaces/IDiamondCut.sol";
import {IDiamondLoupe} from "./interfaces/IDiamondLoupe.sol";
import {IERC165} from "./interfaces/IERC165.sol";
import {IERC173} from "./interfaces/IERC173.sol";
import {IGrcLoupe} from "./interfaces/IGrcLoupe.sol";
import {GRCStorage} from "./libraries/GRCStorage.sol";

contract GrcDiamond is IDiamondCut, IDiamondLoupe, IERC165, IERC173, IGrcLoupe {
    struct SelectorInfo { address facet; }
    mapping(bytes4 => SelectorInfo) internal _selectorInfo;
    address[] private _facetAddresses;              // dynamic list of facet addresses
    mapping(address => bytes4[]) private _facetSelectors; // facet => selectors array
    mapping(address => uint256) private _facetIndex; // facet => index+1 (0 means absent)
    address private _owner;
    string private _grcVersion;

    modifier onlyOwner() { require(msg.sender == _owner, "OWNER"); _; }

    constructor(address owner_, string memory version_) {
        _owner = owner_ == address(0) ? msg.sender : owner_;
        _grcVersion = version_;
        emit OwnershipTransferred(address(0), _owner);
    }

    // IERC173
    function owner() external view override returns (address) { return _owner; }
    function transferOwnership(address newOwner) external override onlyOwner { require(newOwner!=address(0),"ZERO"); emit OwnershipTransferred(_owner,newOwner); _owner=newOwner; }

    // IGrcLoupe minimal wires
    function grcVersion() external view returns (string memory) { return _grcVersion; }
    function getScalarS() external view returns (uint256) { return GRCStorage.monetary().scalarS; }
    function getIndexWeights(bytes32 indexId) external view returns (uint64 ver, bytes32[] memory keys, uint256[] memory weights, bytes32 dashboardHash) {
        GRCStorage.IndexEntry storage ie = GRCStorage.indexEntry(indexId);
        ver = ie.version; keys = ie.keys; weights = ie.weights; dashboardHash = ie.dashboardHash;
    }
    function getPoR(uint64 period) external view returns (bytes32 merkleRoot, string memory ipfs) {
        GRCStorage.AuditPeriod storage ap = GRCStorage.audit(period); merkleRoot=ap.merkleRoot; ipfs=ap.ipfs; }
    function governanceParams() external view returns (uint256 timelockSeconds, uint256 quorumBps) {
        GRCStorage.GovernanceState storage gs = GRCStorage.governance(); return (gs.timelockSeconds, gs.quorumBps); }

    // ERC165
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return interfaceId == type(IERC165).interfaceId ||
               interfaceId == type(IDiamondCut).interfaceId ||
               interfaceId == type(IDiamondLoupe).interfaceId ||
               interfaceId == type(IERC173).interfaceId ||
               interfaceId == type(IGrcLoupe).interfaceId;
    }

    // DiamondCut
    uint256 internal constant ROLE_UPGRADE = 1 << 0;
    function diamondCut(FacetCut[] calldata _cut, address _init, bytes calldata _calldata) external override {
        // access control: owner, internal (self-call), or upgrade role holder
        if(msg.sender != _owner && msg.sender != address(this)) {
            if((GRCStorage.roles().roleBits[msg.sender] & ROLE_UPGRADE) == 0) revert("NO_UPGRADE_ROLE");
        }
        for(uint i; i<_cut.length; i++) {
            FacetCut memory fc = _cut[i];
            if(fc.action == FacetCutAction.Add || fc.action == FacetCutAction.Replace) {
                require(fc.facetAddress != address(0), "FACET_ZERO");
            }
            for(uint s; s<fc.functionSelectors.length; s++) {
                bytes4 sel = fc.functionSelectors[s];
                if(fc.action == FacetCutAction.Add) {
                    require(_selectorInfo[sel].facet == address(0), "EXISTS");
                    _selectorInfo[sel].facet = fc.facetAddress;
                    _addSelectorToFacet(fc.facetAddress, sel);
                } else if(fc.action == FacetCutAction.Replace) {
                    require(_selectorInfo[sel].facet != address(0), "MISSING");
                    address oldFacet = _selectorInfo[sel].facet;
                    if(oldFacet != fc.facetAddress) {
                        _removeSelectorFromFacet(oldFacet, sel);
                        _selectorInfo[sel].facet = fc.facetAddress;
                        _addSelectorToFacet(fc.facetAddress, sel);
                    }
                } else if(fc.action == FacetCutAction.Remove) {
                    require(_selectorInfo[sel].facet != address(0), "MISSING");
                    address oldFacetRemove = _selectorInfo[sel].facet;
                    _selectorInfo[sel].facet = address(0);
                    _removeSelectorFromFacet(oldFacetRemove, sel);
                }
            }
        }
        emit DiamondCut(_cut, _init, _calldata);
        if(_init != address(0)) {
            (bool ok, bytes memory err) = _init.delegatecall(_calldata);
            require(ok, string(err));
        }
    }

    // Loupe minimal (expand later)
    function facets() external view returns (address[] memory facetAddresses, bytes4[][] memory selectors) {
        uint len = _facetAddresses.length;
        facetAddresses = new address[](len);
        selectors = new bytes4[][](len);
        for(uint i; i<len; i++) {
            address f = _facetAddresses[i];
            facetAddresses[i] = f;
            bytes4[] memory sels = _facetSelectors[f];
            selectors[i] = sels;
        }
    }
    function facetFunctionSelectors(address facet) external view returns (bytes4[] memory) { return _facetSelectors[facet]; }
    function facetAddresses() external view returns (address[] memory) { return _facetAddresses; }
    function facetAddress(bytes4 selector) external view returns (address) { return _selectorInfo[selector].facet; }

    // Fallback delegate to facet
    fallback() external payable {
        // pause checks
        GRCStorage.PauseState storage ps = GRCStorage.pause();
        require(!ps.global, "PAUSED_GLOBAL");
        require(!ps.func[msg.sig], "PAUSED_FUNC");
        address facet = _selectorInfo[msg.sig].facet;
        require(facet != address(0), "NO_FACET");
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    receive() external payable {}

    // INTERNALS
    function _addSelectorToFacet(address facet, bytes4 sel) internal {
        if(_facetIndex[facet] == 0) { // new facet
            _facetAddresses.push(facet);
            _facetIndex[facet] = _facetAddresses.length; // index+1
        }
        bytes4[] storage arr = _facetSelectors[facet];
        for(uint i; i<arr.length; i++) { if(arr[i] == sel) return; }
        arr.push(sel);
    }
    function _removeSelectorFromFacet(address facet, bytes4 sel) internal {
        bytes4[] storage arr = _facetSelectors[facet];
        for(uint i; i<arr.length; i++) {
            if(arr[i] == sel) {
                arr[i] = arr[arr.length-1];
                arr.pop();
                break;
            }
        }
        if(arr.length == 0) { _removeFacetAddress(facet); }
    }
    function _removeFacetAddress(address facet) internal {
        uint idxPlus = _facetIndex[facet];
        if(idxPlus == 0) return;
        uint idx = idxPlus - 1;
        uint lastIdx = _facetAddresses.length - 1;
        if(idx != lastIdx) {
            address last = _facetAddresses[lastIdx];
            _facetAddresses[idx] = last;
            _facetIndex[last] = idx + 1;
        }
        _facetAddresses.pop();
        _facetIndex[facet] = 0;
    }
}
