const { ethers } = require('hardhat');

describe('GasBench Triangulation', () => {
    it('measures gas for setRate, triangulate, redeem', async () => {
        const [deployer] = await ethers.getSigners();
        const Diamond = await ethers.getContractFactory('GrcDiamond');
        const d = await Diamond.deploy(deployer.address, 'grc-0.1.0');
        await d.waitForDeployment();
        const Access = await ethers.getContractFactory('AccessFacet');
        const Tri = await ethers.getContractFactory('TriangulationFacet');
        const accessFacet = await Access.deploy(); await accessFacet.waitForDeployment();
        const triFacetImpl = await Tri.deploy(); await triFacetImpl.waitForDeployment();
        const addSelectors = c => c.interface.fragments.filter(f => f.type === 'function').map(f => c.interface.getFunction(f.name).selector);
        await d.diamondCut([
            { facetAddress: await accessFacet.getAddress(), action: 0, functionSelectors: addSelectors(accessFacet) },
            { facetAddress: await triFacetImpl.getAddress(), action: 0, functionSelectors: addSelectors(triFacetImpl) }
        ], ethers.ZeroAddress, '0x');
        const access = await ethers.getContractAt('AccessFacet', await d.getAddress());
        const tri = await ethers.getContractAt('TriangulationFacet', await d.getAddress());
        await access.grantRoles(deployer.address, await access.ROLE_GOVERNANCE_BIT());
        const GOLD = ethers.id('XAU');
        const GRU = ethers.id('GRU');
        const setTx = await tri.setRate(GOLD, GRU, 2n * 10n ** 18n);
        const setRcpt = await setTx.wait();
        await tri.setFees(100n);
        const triangulateTx = await tri.triangulate(GOLD, GRU, 1000n);
        const triRcpt = await triangulateTx.wait();
        const redeemTx = await tri.redeem(GRU, GOLD, 1000n);
        const redeemRcpt = await redeemTx.wait();
        const gasData = {
            timestamp: Math.floor(Date.now() / 1000),
            setRate: setRcpt.gasUsed.toString(),
            triangulate: triRcpt.gasUsed.toString(),
            redeem: redeemRcpt.gasUsed.toString()
        };
        console.log('Gas setRate:', gasData.setRate);
        console.log('Gas triangulate:', gasData.triangulate);
        console.log('Gas redeem:', gasData.redeem);
        // Persist to artifact JSON
        const fs = require('fs');
        const path = require('path');
        // Write under test/gas so summary script can locate it
        const dir = path.join(__dirname, 'gas');
        if (!fs.existsSync(dir)) fs.mkdirSync(dir);
        const file = path.join(dir, 'triangulation.json');
        let existing = [];
        if (fs.existsSync(file)) {
            try { existing = JSON.parse(fs.readFileSync(file, 'utf8')); } catch (e) { existing = []; }
        }
        existing.push(gasData);
        fs.writeFileSync(file, JSON.stringify(existing, null, 2));
    });
});
