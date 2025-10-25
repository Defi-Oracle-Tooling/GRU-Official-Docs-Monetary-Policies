#!/usr/bin/env node
/*
 Aggregates gas benchmark entries from test/gas/triangulation.json into summary stats.
 Output: test/gas/triangulation.summary.json
*/
const fs = require('fs');
const path = require('path');
const src = path.join(__dirname, '..', 'test', 'gas', 'triangulation.json');
const out = path.join(__dirname, '..', 'test', 'gas', 'triangulation.summary.json');
if (!fs.existsSync(src)) {
    console.error('No triangulation.json found; run gas benchmark test first.');
    process.exit(1);
}
let data;
try { data = JSON.parse(fs.readFileSync(src, 'utf8')); } catch (e) { console.error('Failed to parse triangulation.json'); process.exit(1); }
if (!Array.isArray(data)) { console.error('triangulation.json not array'); process.exit(1); }
function summarize(metric) {
    const vals = data.map(r => BigInt(r[metric]));
    if (!vals.length) return null;
    const min = vals.reduce((a, b) => a < b ? a : b);
    const max = vals.reduce((a, b) => a > b ? a : b);
    const sum = vals.reduce((a, b) => a + b, 0n);
    const avg = sum / BigInt(vals.length);
    return { min: min.toString(), max: max.toString(), avg: avg.toString(), samples: vals.length };
}
const summary = {
    generatedAt: Math.floor(Date.now() / 1000),
    setRate: summarize('setRate'),
    triangulate: summarize('triangulate'),
    redeem: summarize('redeem')
};
fs.writeFileSync(out, JSON.stringify(summary, null, 2));
console.log('Wrote summary to', out);
