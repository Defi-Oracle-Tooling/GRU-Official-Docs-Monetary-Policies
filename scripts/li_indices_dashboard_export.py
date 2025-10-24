#!/usr/bin/env python3
"""
GRU Li-Indices Dashboard Exporter
- Reads YAML/CSV weights and index values
- Computes LiCRI and M00 composite
- Outputs dashboard JSON for web or PDF embedding
"""
import yaml
import csv
import json
from datetime import datetime

# Config
YAML_PATH = 'docs/meta/li_indices_weights.yaml'
CSV_PATH = 'docs/meta/li_indices_weights.csv'
INDEX_VALUES_PATH = 'docs/meta/li_indices_values.json'  # Expects {LiXAU:..., LiPMG:..., ...}
DASHBOARD_OUT = 'docs/meta/li_indices_dashboard.json'

# Load weights from YAML
with open(YAML_PATH, 'r') as f:
    weights = yaml.safe_load(f)

# Load index values (example: from oracle feed or manual entry)
try:
    with open(INDEX_VALUES_PATH, 'r') as f:
        index_values = json.load(f)
except FileNotFoundError:
    # Placeholder values for demo
    index_values = {
        'LiXAU': 100.0,
        'LiPMG': 98.5,
        'LiBMG1': 95.2,
        'LiBMG2': 102.3,
        'LiBMG3': 97.7
    }

# Compute LiCRI (face-value composite)
li_indices = ['LiXAU', 'LiPMG', 'LiBMG1', 'LiBMG2', 'LiBMG3']
li_sum = sum(index_values[k] for k in li_indices)
li_cri = li_sum / 5

# Compute M00 composite (asset-backed collateral)
m00_composite = 1.2 * li_sum

# Dashboard output
dashboard = {
    'timestamp': datetime.utcnow().isoformat() + 'Z',
    'weights_version': weights.get('indices', {}),
    'index_values': index_values,
    'LiCRI': li_cri,
    'M00_composite': m00_composite,
    'formulas': {
        'LiCRI': '(LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5',
        'M00_composite': '1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)'
    },
    'scalar_S': weights.get('scalar_S'),
    'audit_fields': {
        'effective_date': datetime.utcnow().strftime('%Y-%m-%d'),
        'registry_record': f'DSL#GRU-LiCRI-M00-{datetime.utcnow().strftime("%Y%m%d")}'
    }
}

with open(DASHBOARD_OUT, 'w') as f:
    json.dump(dashboard, f, indent=2)

print(f"[DONE] Dashboard exported to {DASHBOARD_OUT}")
