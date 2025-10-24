const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('GrcDiamond', () => {
    it('deploys and exposes version + owner', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const diamond = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await diamond.waitForDeployment();
        expect(await diamond.owner()).to.equal(deployer.address);
        expect(await diamond.grcVersion()).to.equal('grc-0.1.0');
    });
    it('supports core interfaces including IGrcLoupe', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const IERC165_ID = '0x01ffc9a7';
        const IDiamondCut_ID = '0x1f931c1c';
        const IDiamondLoupe_ID = '0x48e2b093';
        const IERC173_ID = '0x7f5828d0';
        const IGrcLoupe_ID = xorSelectors([
            'grcVersion()',
            'getScalarS()',
            'getIndexWeights(bytes32)',
            'getPoR(uint64)',
            'governanceParams()'
        ]);
        expect(await d.supportsInterface(IERC165_ID)).to.equal(true);
        expect(await d.supportsInterface(IDiamondCut_ID)).to.equal(true);
        expect(await d.supportsInterface(IDiamondLoupe_ID)).to.equal(true);
        expect(await d.supportsInterface(IERC173_ID)).to.equal(true);
        expect(await d.supportsInterface(IGrcLoupe_ID)).to.equal(true);
    });
    it('loupe enumeration after adding MonetaryFacet', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const mf = await Monetary.deploy();
        await mf.waitForDeployment();
        // derive function selectors from interface fragments (ethers v6)
        const selectors = mf.interface.fragments
            .filter(f => f.type === 'function')
            .map(f => mf.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await mf.getAddress(), action: 0, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        const [facetAddresses, facetSelectors] = await d.facets();
        expect(facetAddresses.length).to.equal(1);
        expect(facetAddresses[0]).to.equal(await mf.getAddress());
        expect(facetSelectors[0].length).to.equal(selectors.length);
        for (const sel of selectors) { expect(facetSelectors[0]).to.include(sel); }
        const single = await d.facetFunctionSelectors(await mf.getAddress());
        expect(single.length).to.equal(selectors.length);
        const addressesOnly = await d.facetAddresses();
        expect(addressesOnly.length).to.equal(1);
        expect(addressesOnly[0]).to.equal(await mf.getAddress());
    });
    it('replace facet selectors with new facet address', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const mf1 = await Monetary.deploy(); await mf1.waitForDeployment();
        const mf2 = await Monetary.deploy(); await mf2.waitForDeployment();
        const selectors = mf1.interface.fragments.filter(f => f.type === 'function').map(f => mf1.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await mf1.getAddress(), action: 0, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        // replace with second facet instance
        await d.diamondCut([{ facetAddress: await mf2.getAddress(), action: 1, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        const [facetAddresses, facetSelectors] = await d.facets();
        expect(facetAddresses.length).to.equal(1);
        expect(facetAddresses[0]).to.equal(await mf2.getAddress());
        expect(facetSelectors[0].length).to.equal(selectors.length);
        // old facet should have no selectors
        const oldSelectors = await d.facetFunctionSelectors(await mf1.getAddress());
        expect(oldSelectors.length).to.equal(0);
    });
    it('remove facet selectors and prune facet address', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const mf = await Monetary.deploy(); await mf.waitForDeployment();
        const selectors = mf.interface.fragments.filter(f => f.type === 'function').map(f => mf.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await mf.getAddress(), action: 0, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        // remove all selectors (action=2 facetAddress can be zero)
        await d.diamondCut([{ facetAddress: ethers.ZeroAddress, action: 2, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        const [facetAddresses, facetSelectors] = await d.facets();
        expect(facetAddresses.length).to.equal(0);
        expect(facetSelectors.length).to.equal(0);
        for (const sel of selectors) {
            expect(await d.facetAddress(sel)).to.equal(ethers.ZeroAddress);
        }
    });
    it('sets index weights and dashboard hash via IndexFacet', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Index = await ethers.getContractFactory('IndexFacet');
        const idx = await Index.deploy(); await idx.waitForDeployment();
        // add IndexFacet selectors
        const selectors = idx.interface.fragments.filter(f => f.type === 'function').map(f => idx.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await idx.getAddress(), action: 0, functionSelectors: selectors }], ethers.ZeroAddress, '0x');
        // add access facet & grant index role
        const Access = await ethers.getContractFactory('AccessFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const accessSelectors = accessFacet.interface.fragments.filter(f => f.type === 'function').map(f => accessFacet.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: accessSelectors }], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const ROLE_INDEX = await access.ROLE_INDEX_BIT();
        await access.grantRoles(deployer.address, ROLE_INDEX);
        const indexId = ethers.id('LiPMG');
        const keys = [ethers.id('Au'), ethers.id('Ag'), ethers.id('Pt'), ethers.id('Pd'), ethers.id('Rh')];
        const rawWeights = [
            400000000000000000n,
            200000000000000000n,
            180000000000000000n,
            150000000000000000n,
            70000000000000000n
        ];
        // sum validation is 1e18 (1.0 in fixed point)
        const dashboardHash = ethers.keccak256(ethers.toUtf8Bytes('dashboard:LiCRI:2025-10-24'));
        const indexFacet = await ethers.getContractAt('IndexFacet', await d.getAddress());
        await indexFacet.setWeights(indexId, keys, rawWeights, 1n, dashboardHash);
        const data = await indexFacet.getIndex(indexId);
        expect(data[0]).to.equal(1n); // version
        expect(data[3]).to.equal(dashboardHash); // dashboard hash
        expect(data[1].length).to.equal(keys.length);
        // verify through diamond loupe extension
        const viaLoupe = await d.getIndexWeights(indexId);
        expect(viaLoupe[0]).to.equal(1n);
        expect(viaLoupe[3]).to.equal(dashboardHash);
    });
    it('weighted LiCRI composite calculation', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Index = await ethers.getContractFactory('IndexFacet');
        const idx = await Index.deploy(); await idx.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([{ facetAddress: await idx.getAddress(), action: 0, functionSelectors: addSelectors(idx) }], ethers.ZeroAddress, '0x');
        const Access = await ethers.getContractFactory('AccessFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        await d.diamondCut([{ facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) }], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        await access.grantRoles(deployer.address, await access.ROLE_INDEX_BIT());
        const indexFacet = await ethers.getContractAt('IndexFacet', await d.getAddress());
        const ids = [ethers.id('LiXAU'), ethers.id('LiPMG'), ethers.id('LiBMG1')];
        const values = [1000n, 2000n, 4000n];
        const weights = [500000000000000000n, 300000000000000000n, 200000000000000000n]; // sum 1e18
        const wLiCRI = await indexFacet.recalcLiCRIWeighted.staticCall(ids, values, weights);
        // expected weighted = 1000*0.5 + 2000*0.3 + 4000*0.2 = 500 + 600 + 800 = 1900
        expect(wLiCRI).to.equal(1900n);
        await indexFacet.recalcLiCRIWeighted(ids, values, weights);
        expect(await indexFacet.getLiCRI()).to.equal(1900n);
    });
    it('audit facet record and seal', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Audit = await ethers.getContractFactory('AuditFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const auditFacetImpl = await Audit.deploy(); await auditFacetImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await auditFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(auditFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const audit = await ethers.getContractAt('AuditFacet', await d.getAddress());
        await access.grantRoles(deployer.address, await access.ROLE_GOVERNANCE_BIT());
        await audit.postPoR(1, ethers.id('root1'), 'ipfs://hash1');
        const por = await audit.getPoR(1);
        expect(por[0]).to.equal(ethers.id('root1'));
        expect(por[1]).to.equal('ipfs://hash1');
        await audit.seal(1);
        const por2 = await audit.getPoR(1);
        expect(por2[2]).to.equal(true);
        await expect(audit.postPoR(1, ethers.id('root2'), 'ipfs://hash2')).to.be.revertedWithCustomError(audit, 'ErrPeriodSealed');
    });
    it('triangulation rates and fee application', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Tri = await ethers.getContractFactory('TriangulationFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const triFacetImpl = await Tri.deploy(); await triFacetImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await triFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(triFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const tri = await ethers.getContractAt('TriangulationFacet', await d.getAddress());
        await access.grantRoles(deployer.address, await access.ROLE_GOVERNANCE_BIT());
        const GOLD = ethers.id('XAU');
        const GRU = ethers.id('GRU');
        await tri.setRate(GOLD, GRU, 2n * 10n ** 18n); // 2 GRU per XAU
        await tri.setFees(100n); // 1%
        const preview = await tri.triangulate.staticCall(GOLD, GRU, 1000n); // 1000 * 2 = 2000 -1% = 1980
        expect(preview).to.equal(1980n);
        const tx = await tri.triangulate(GOLD, GRU, 1000n);
        await tx.wait();
        const previewAfter = await tri.triangulate.staticCall(GOLD, GRU, 1000n);
        expect(previewAfter).to.equal(1980n);
        await expect(tri.redeem.staticCall(GRU, GOLD, 500n)).to.be.revertedWithCustomError(tri, 'ErrRateUnset');
        await expect(tri.redeem(GRU, GOLD, 500n)).to.be.revertedWithCustomError(tri, 'ErrRateUnset');
    });
    it('monetary scalar bounds enforced', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const monFacetImpl = await Monetary.deploy(); await monFacetImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await monFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(monFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const mon = await ethers.getContractAt('MonetaryFacet', await d.getAddress());
        await access.grantRoles(deployer.address, await access.ROLE_MONETARY_BIT());
        await mon.setScalarS(123n);
        await expect(mon.setScalarS(10000000000000000000000001n)).to.be.revertedWithCustomError(mon, 'ErrScalarBounds');
    });
    it('governance proposes, queues, executes diamondCut adding MonetaryFacet', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Gov = await ethers.getContractFactory('GovernanceFacet');
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const govFacet = await Gov.deploy(); await govFacet.waitForDeployment();
        // add access & governance facets to diamond so we can call them through diamond
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await govFacet.getAddress(), action: 0, functionSelectors: addSelectors(govFacet) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const gov = await ethers.getContractAt('GovernanceFacet', await d.getAddress());
        // grant governance and upgrade roles to deployer
        const ROLE_GOV = await access.ROLE_GOVERNANCE_BIT();
        const ROLE_UP = await access.ROLE_UPGRADE_BIT();
        await access.grantRoles(deployer.address, ROLE_GOV | ROLE_UP);
        // set timelock to 1 hour
        await gov.setGovernanceParams(3600, 0);
        // Prepare monetary facet cut (not yet added)
        const monetaryFacet = await Monetary.deploy(); await monetaryFacet.waitForDeployment();
        const mSelectors = addSelectors(monetaryFacet);
        const proposalId = ethers.keccak256(ethers.toUtf8Bytes('proposal-monetary-1'));
        await gov.proposeCut(proposalId, [{ facetAddress: await monetaryFacet.getAddress(), action: 0, functionSelectors: mSelectors }], ethers.ZeroAddress, '0x');
        await gov.queueCut(proposalId);
        const eta = await gov.eta(proposalId);
        // attempt premature execute should fail
        await expect(gov.executeCut(proposalId)).to.be.revertedWithCustomError(gov, 'ErrNotReady');
        // fast-forward time
        const increaseBy = Number(eta) - Math.floor(Date.now() / 1000) + 2; // ensure past eta
        await ethers.provider.send('evm_increaseTime', [increaseBy]);
        await ethers.provider.send('evm_mine', []);
        await gov.executeCut(proposalId);
        // verify facet now present
        const [facetAddresses] = await d.facets();
        expect(facetAddresses).to.include(await monetaryFacet.getAddress());
    });
    it('role enforcement prevents unauthorized index updates', async () => {
        const [deployer, attacker] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Index = await ethers.getContractFactory('IndexFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const indexFacetImpl = await Index.deploy(); await indexFacetImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await indexFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(indexFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const index = await ethers.getContractAt('IndexFacet', await d.getAddress());
        const ROLE_INDEX = await access.ROLE_INDEX_BIT();
        // attacker tries without role
        const hundred = 100n * 10n ** 18n;
        await expect(index.connect(attacker).setIndexValue(ethers.id('LiXAU'), hundred)).to.be.revertedWithCustomError(index, 'ErrIndexRole');
        // grant role
        await access.grantRoles(deployer.address, ROLE_INDEX);
        await index.setIndexValue(ethers.id('LiXAU'), hundred);
        expect(await index.getIndexValue(ethers.id('LiXAU'))).to.equal(hundred);
    });
    it('bond series issuance and coupon accrual functions', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Bond = await ethers.getContractFactory('BondFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const bondFacetImpl = await Bond.deploy(); await bondFacetImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await bondFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(bondFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const bond = await ethers.getContractAt('BondFacet', await d.getAddress());
        const ROLE_GOV = await access.ROLE_GOVERNANCE_BIT();
        await access.grantRoles(deployer.address, ROLE_GOV);
        const series = ethers.id('Li99-2025A');
        await bond.issueLi99(series, deployer.address, 1_000_000n);
        await ethers.provider.send('evm_increaseTime', [30 * 24 * 3600]); // advance ~30 days
        await ethers.provider.send('evm_mine', []);
        const accruedPreview = await bond.accrueCoupons.staticCall(series);
        expect(accruedPreview).to.be.gt(0n);
        await bond.accrueCoupons(series);
        const coverage = await bond.coverageCheck(series);
        expect(coverage[0]).to.equal(true);
        const closedPreview = await bond.buyback.staticCall(series);
        expect(closedPreview).to.equal(1_000_000n);
        await bond.buyback(series);
    });
    it('pause system blocks facet calls', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0'); await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Pause = await ethers.getContractFactory('PauseFacet');
        const Monetary = await ethers.getContractFactory('MonetaryFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const pauseFacetImpl = await Pause.deploy(); await pauseFacetImpl.waitForDeployment();
        const monetaryImpl = await Monetary.deploy(); await monetaryImpl.waitForDeployment();
        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await pauseFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(pauseFacetImpl) },
            { facetAddress: await monetaryImpl.getAddress(), action: 0, functionSelectors: addSelectors(monetaryImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const pause = await ethers.getContractAt('PauseFacet', await d.getAddress());
        const ROLE_MON = await access.ROLE_MONETARY_BIT();
        await access.grantRoles(deployer.address, ROLE_MON | (await access.ROLE_GOVERNANCE_BIT()));
        // function selector for setScalarS(uint256)
        const sel = monetaryImpl.interface.getFunction('setScalarS').selector;
        await pause.setFunctionPause(sel, true);
        const monetary = await ethers.getContractAt('MonetaryFacet', await d.getAddress());
        await expect(monetary.setScalarS(123n)).to.be.revertedWithCustomError(d, 'ErrPausedFunc');
        await pause.setFunctionPause(sel, false);
        await monetary.setScalarS(123n);
        // global pause
        await pause.setGlobalPause(true);
        await expect(monetary.setScalarS(456n)).to.be.revertedWithCustomError(d, 'ErrPausedGlobal');
    });
});

function xorSelectors(signatures) {
    const { keccak256, toUtf8Bytes } = ethers;
    let result = 0n;
    for (const sig of signatures) {
        const sel = keccak256(toUtf8Bytes(sig)).slice(0, 10);
        result ^= BigInt(sel);
    }
    return '0x' + result.toString(16).padStart(8, '0');
}
