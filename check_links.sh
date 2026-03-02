#!/bin/bash
# Link Checker for GRU Monetary Policies Site
# Tests all internal links and reports status

SITE_URL="https://monetary-policies.d-bis.org"
FAILED_LINKS=()
PASSED_LINKS=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Checking links on $SITE_URL"
echo "=================================="
echo ""

# Function to check a link
check_link() {
    local url="$1"
    local name="${2:-$url}"
    local full_url="${SITE_URL}${url}"
    
    local status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$full_url" 2>/dev/null)
    local time=$(curl -s -o /dev/null -w "%{time_total}" --max-time 10 "$full_url" 2>/dev/null)
    
    if [ "$status" = "200" ]; then
        echo -e "${GREEN}✓${NC} $name (${status}) - ${time}s"
        PASSED_LINKS+=("$url")
        return 0
    elif [ "$status" = "404" ]; then
        echo -e "${RED}✗${NC} $name (${status} - Not Found)"
        FAILED_LINKS+=("$url")
        return 1
    elif [ "$status" = "000" ]; then
        echo -e "${YELLOW}⚠${NC} $name (Timeout/Error)"
        FAILED_LINKS+=("$url")
        return 1
    else
        echo -e "${YELLOW}⚠${NC} $name (${status})"
        FAILED_LINKS+=("$url")
        return 1
    fi
}

# Core Documents
echo "📋 Core Documents:"
check_link "/core/00-gru-executive-summary/" "Executive Summary"
check_link "/core/01-gru-monetary-policy-framework/" "Monetary Policy Framework"
check_link "/core/02-gru-triangulation-emoney-creation/" "Triangulation & eMoney Creation"
check_link "/core/03-gru-bond-system-liquidity-management/" "Bond System & Liquidity"
check_link "/core/04-gru-governance-regulatory-oversight/" "Governance & Oversight"
check_link "/core/05-digital-bank-for-international-settlements-charter/" "DBIS Charter"
check_link "/core/06-gru-enhancement-expansion-roadmap/" "Enhancement Roadmap"
check_link "/core/07-omnl-central-bank-dbis-operational-manual/" "OMNL Operational Manual"
echo ""

# Meta Documents
echo "📚 Meta Documents:"
check_link "/meta/gru-formulas/" "GRU Formulas"
check_link "/meta/glossary/" "Glossary"
check_link "/meta/risk-annex/" "Risk Annex"
echo ""

# Compliance - SEPA
echo "🏛️ Compliance - SEPA:"
check_link "/compliance/sepa-compliance-matrix/" "SEPA Compliance Matrix"
check_link "/compliance/ipr-compliance-memo/" "IPR Compliance Memo"
echo ""

# Compliance - MiCA
echo "🏛️ Compliance - MiCA:"
check_link "/compliance/legal-position-gru-vs-mica/" "Legal Position GRU vs MiCA"
check_link "/compliance/issuer-obligations-readiness/" "Issuer Obligations Readiness"
echo ""

# Compliance - DORA
echo "🏛️ Compliance - DORA:"
check_link "/compliance/ict-risk-policy/" "ICT Risk Policy"
check_link "/compliance/incident-response-runbook/" "Incident Response Runbook"
echo ""

# Compliance - AML
echo "🏛️ Compliance - AML:"
check_link "/compliance/enterprise-wide-risk-assessment/" "Enterprise Wide Risk Assessment"
echo ""

# Key Pages
echo "🔗 Key Pages:"
check_link "/" "Homepage"
check_link "/search/" "Search Page"
check_link "/404.html" "404 Error Page"
echo ""

# Summary
echo "=================================="
echo "📊 Summary:"
echo -e "${GREEN}Passed: ${#PASSED_LINKS[@]}${NC}"
echo -e "${RED}Failed: ${#FAILED_LINKS[@]}${NC}"
echo ""

if [ ${#FAILED_LINKS[@]} -gt 0 ]; then
    echo -e "${RED}Failed Links:${NC}"
    for link in "${FAILED_LINKS[@]}"; do
        echo "  - $link"
    done
    exit 1
else
    echo -e "${GREEN}All links are working! ✓${NC}"
    exit 0
fi

