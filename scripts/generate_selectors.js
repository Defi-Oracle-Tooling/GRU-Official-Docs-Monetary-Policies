#!/usr/bin/env node
/*
Generate function selectors for a compiled contract.
Usage: node scripts/generate_selectors.js MonetaryFacet
Looks for artifacts in artifacts/contracts/<Name>.sol/<Name>.json
*/
const fs = require('fs');
const path = require('path');
const { keccak256, toUtf8Bytes } = require('ethers');

function selector(sig) { return keccak256(toUtf8Bytes(sig)).slice(0, 10); }

function main() {
    const name = process.argv[2];
    if (!name) { console.error('Contract name required'); process.exit(1); }
    // Attempt to derive .sol filename by convention (Name.sol)
    const artifactPath = path.join(__dirname, '..', 'artifacts', 'contracts', `${name}.sol`, `${name}.json`);
    if (!fs.existsSync(artifactPath)) {
        console.error('Artifact not found:', artifactPath); process.exit(1);
    }
    const artifact = JSON.parse(fs.readFileSync(artifactPath, 'utf8'));
    const abi = artifact.abi || [];
    const out = {};
    for (const item of abi) {
        if (item.type === 'function') {
            const inputs = (item.inputs || []).map(i => i.type).join(',');
            const sig = `${item.name}(${inputs})`;
            out[sig] = selector(sig);
        }
    }
    console.log(JSON.stringify({ contract: name, selectors: out }, null, 2));
}

main();
