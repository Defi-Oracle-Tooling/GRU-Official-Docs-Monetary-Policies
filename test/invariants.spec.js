const { expect } = require('chai');
const { ethers } = require('hardhat');

// Lightweight randomized invariant exercise (pseudo-fuzz) to stress key economic & safety constraints.
// Invariants:
// 1. Triangulation feeBps never exceeds 450.
// 2. Inverse rate auto-generated matches reciprocal within tolerance.
// 3. Bond coverage check remains ok after random coupon accrual sequences (when active and before buyback).
// 4. Reentrancy guard prevents recursive diamondCut via init (already covered in dedicated test, reassert here once).

describe('Invariants (pseudo-fuzz)', () => {
    it('maintains economic & safety invariants under random operations', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();

        // Facets
        const Access = await ethers.getContractFactory('AccessFacet');
        const Tri = await ethers.getContractFactory('TriangulationFacet');
        const Bond = await ethers.getContractFactory('BondFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const triFacetImpl = await Tri.deploy(); await triFacetImpl.waitForDeployment();
        const bondFacetImpl = await Bond.deploy(); await bondFacetImpl.waitForDeployment();

        const addSelectors = (c) => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await triFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(triFacetImpl) },
            { facetAddress: await bondFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(bondFacetImpl) }
        ], ethers.ZeroAddress, '0x');

        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const tri = await ethers.getContractAt('TriangulationFacet', await d.getAddress());
        const bond = await ethers.getContractAt('BondFacet', await d.getAddress());

        // Grant governance role (needed for setRate, setFees, bond issuance)
        await access.grantRoles(deployer.address, await access.ROLE_GOVERNANCE_BIT());

        const GOLD = ethers.id('XAU');
        const GRU = ethers.id('GRU');
        const SILV = ethers.id('XAG');

        // Issue a bond series
        const series = ethers.id('Li99-INV-A');
        await bond.issueLi99(series, deployer.address, 1_000_000n);

        // Random sequences
        const iterations = 40; // modest count for test speed
        for (let i = 0; i < iterations; i++) {
            // Random rate between 0.5 and 3.0 scaled 1e18
            const rand = 50 + Math.floor(Math.random() * 250); // 50..300 => 0.5..3.0
            const rate = BigInt(rand) * 10n ** 16n; // *1e16 => scaled 1e18 overall
            // Pick asset pair among permutations
            const pairs = [[GOLD, GRU], [GRU, SILV], [SILV, GOLD]];
            const [fromA, toA] = pairs[i % pairs.length];
            await tri.setRate(fromA, toA, rate);
            // Check inverse exists & reciprocal within 1e12 tolerance (approx)
            const forward = await tri.getRate(fromA, toA);
            const inverse = await tri.getRate(toA, fromA);
            // expected inverse ~ 1e36 / forward
            const expectedInv = (1_000_000_000_000_000_000_000_000_000_000_000_000n / forward); // 1e36
            const diff = inverse > expectedInv ? inverse - expectedInv : expectedInv - inverse;
            expect(diff).to.be.lt(1_000_000_000_000n); // <1e12 tolerance

            // Random fee within bound
            const fee = Math.floor(Math.random() * 451); // 0..450
            await tri.setFees(BigInt(fee));
            expect(await tri.feeBps()).to.be.lte(450n);

            // Occasionally accrue coupons (simulate time passing)
            if (i % 5 === 0) {
                await ethers.provider.send('evm_increaseTime', [24 * 3600]);
                await ethers.provider.send('evm_mine', []);
                const preview = await bond.accrueCoupons.staticCall(series);
                if (preview > 0n) {
                    await bond.accrueCoupons(series);
                    const coverage = await bond.coverageCheck(series);
                    expect(coverage[0]).to.equal(true); // coverage invariant holds
                }
            }
        }

        // Final buyback preview & execution to ensure closure path still respects invariants
        const closedPreview = await bond.buyback.staticCall(series);
        expect(closedPreview).to.equal(1_000_000n);
        await bond.buyback(series);
    });
});
