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
