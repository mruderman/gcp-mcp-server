#!/bin/bash
# Security scan script for gcp-mcp-server
# This script runs comprehensive security checks

set -e

echo "🔒 Running security scan for gcp-mcp-server..."

# Create reports directory
mkdir -p security-reports

# Check if security dependencies are installed
echo "📦 Checking security dependencies..."
if ! command -v bandit &> /dev/null; then
    echo "Installing security dependencies..."
    pip install -e ".[security]"
fi

echo "🔍 Running Bandit security scan..."
bandit -r . -f json -o security-reports/bandit-report.json || true
bandit -r . || true

echo "🛡️ Running Safety vulnerability check..."
safety check --json --output security-reports/safety-report.json || true
safety check || true

echo "🔎 Running pip-audit..."
pip-audit --format=json --output=security-reports/pip-audit-report.json || true
pip-audit || true

echo "🔐 Running secrets detection..."
detect-secrets scan . --force-use-all-plugins > security-reports/secrets-report.json || true

echo "📋 Generating Software Bill of Materials (SBOM)..."
if command -v cyclonedx-py &> /dev/null; then
    cyclonedx-py env -o security-reports/sbom.json
else
    echo "Installing cyclonedx-bom..."
    pip install cyclonedx-bom
    cyclonedx-py env -o security-reports/sbom.json
fi

echo "✅ Security scan complete! Reports saved to security-reports/"
echo ""
echo "📊 Summary:"
echo "  - Bandit report: security-reports/bandit-report.json"
echo "  - Safety report: security-reports/safety-report.json"
echo "  - pip-audit report: security-reports/pip-audit-report.json"
echo "  - Secrets report: security-reports/secrets-report.json"
echo "  - SBOM: security-reports/sbom.json"
echo ""
echo "🔍 Review the reports for any security issues."