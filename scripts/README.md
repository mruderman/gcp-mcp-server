# Security Development Tools

This directory contains tools and scripts for security testing and validation.

## Usage

### Install Security Tools
```bash
pip install -e ".[security]"
```

### Run Security Scan
```bash
./scripts/security-scan.sh
```

### Run All Security Checks
```bash
./scripts/security-check-all.sh
```

### Generate Security Report
```bash
./scripts/security-report.sh
```

## Tools Included

- **Bandit**: Python security linter
- **Safety**: Dependency vulnerability scanner  
- **pip-audit**: Python package auditing
- **Semgrep**: Static analysis for security
- **detect-secrets**: Secrets detection
- **SBOM Generation**: Software Bill of Materials

## Reports

Security scan reports are saved to the `security-reports/` directory:

- `bandit-report.json` - Security lint results
- `safety-report.json` - Dependency vulnerabilities
- `pip-audit-report.json` - Package audit results
- `secrets-report.json` - Secrets detection results
- `sbom.json` - Software Bill of Materials

## Integration

These tools are integrated into:
- Pre-commit hooks
- GitHub Actions workflows
- Development workflow