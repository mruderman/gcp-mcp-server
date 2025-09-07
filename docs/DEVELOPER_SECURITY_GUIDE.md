# Developer Security Setup Guide

This guide helps developers set up the security tools and workflows for the gcp-mcp-server project.

## Quick Setup

### 1. Install Security Dependencies
```bash
# Install all development and security dependencies
pip install -e ".[dev,security]"
```

### 2. Set Up Pre-commit Hooks
```bash
# Install and configure pre-commit hooks
pre-commit install

# Run all hooks on all files (first time)
pre-commit run --all-files
```

### 3. Configure Environment
```bash
# Copy environment template
cp .env.example .env

# Edit .env with your configuration
# Use Application Default Credentials when possible
# NEVER commit .env file to git
```

### 4. Run Security Scan
```bash
# Run comprehensive security check
./scripts/security-check-all.sh

# Or run just the security scan
./scripts/security-scan.sh
```

## Daily Development Workflow

### Before Committing Code
1. **Pre-commit hooks run automatically** - Fix any issues they find
2. **Review security warnings** - Address any security findings
3. **Check for secrets** - Ensure no credentials are being committed

### Security Commands
```bash
# Check code for security issues
bandit -r .

# Check dependencies for vulnerabilities  
safety check
pip-audit

# Check for secrets
detect-secrets scan .

# Lint with security rules
ruff check .
```

## Security Best Practices

### 1. Credential Management
- ✅ Use Application Default Credentials (ADC)
- ✅ Store credentials in environment variables
- ✅ Use `.env` files for local development (don't commit)
- ❌ Never hardcode credentials in code
- ❌ Never commit service account keys

### 2. Dependency Management
- ✅ Pin dependency versions with upper bounds
- ✅ Regularly update dependencies
- ✅ Review dependency security advisories
- ❌ Don't use dependencies with known vulnerabilities

### 3. Code Security
- ✅ Follow secure coding practices
- ✅ Validate all inputs
- ✅ Use parameterized queries
- ✅ Handle errors securely
- ❌ Don't ignore security warnings

## Security Tools Overview

| Tool | Purpose | When It Runs |
|------|---------|--------------|
| **Bandit** | Python security linting | Pre-commit, CI |
| **Safety** | Dependency vulnerability scanning | Pre-commit, CI, Daily |
| **pip-audit** | Python package auditing | CI, Daily |
| **detect-secrets** | Secrets detection | Pre-commit, CI |
| **Semgrep** | Static analysis security testing | CI |
| **CodeQL** | Semantic code analysis | CI |
| **Ruff** | Code quality with security rules | Pre-commit, CI |
| **TruffleHog** | Git history secrets scanning | CI |

## Fixing Common Security Issues

### 1. Bandit Warnings
```bash
# View Bandit issues
bandit -r .

# Fix or suppress with comments
# nosec - only if you're sure it's safe
assert condition  # nosec B101
```

### 2. Dependency Vulnerabilities
```bash
# Update vulnerable packages
pip install --upgrade package-name

# Or pin to secure version in pyproject.toml
```

### 3. Secrets Detection
```bash
# If secrets are detected:
# 1. Remove the secret from code
# 2. Rotate the credential if it was real
# 3. Add to .secrets.baseline if false positive
detect-secrets scan --update .secrets.baseline
```

## IDE Setup

### VS Code Extensions
- **Python** - Microsoft
- **Pylance** - Microsoft  
- **Bandit** - Security linting
- **GitLens** - Git security history
- **SARIF Viewer** - View security scan results

### PyCharm Plugins
- **Security** - Security scanning
- **SonarLint** - Code quality and security
- **Requirements** - Dependency analysis

## Security Checklist

Before pushing code, ensure:

- [ ] Pre-commit hooks pass
- [ ] No security warnings in code
- [ ] No credentials in code or config
- [ ] Dependencies are up to date
- [ ] Security scan passes
- [ ] Code review includes security considerations

## Getting Help

### Security Issues
- **Report security vulnerabilities**: security@example.com
- **Security documentation**: `docs/SECURITY_CONFIG.md`
- **Security audit summary**: `docs/SECURITY_AUDIT_SUMMARY.md`

### Development Issues  
- **GitHub Issues**: For bugs and feature requests
- **Discussions**: For questions and help
- **Wiki**: For additional documentation

## Emergency Procedures

### If You Accidentally Commit a Secret
1. **Don't panic** - Follow these steps immediately
2. **Rotate the credential** - Change passwords/keys immediately
3. **Remove from git history** - Contact team lead for help
4. **Update .gitignore** - Prevent similar incidents
5. **Report the incident** - Follow security incident procedures

### If Security Scan Fails
1. **Review the findings** - Check security reports
2. **Address critical issues first** - Priority order: Critical > High > Medium > Low
3. **Get help if needed** - Contact security team or team lead
4. **Document any exceptions** - With approval and justification

## Resources

- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [Python Security Guidelines](https://python.org/dev/security/)
- [Google Cloud Security Best Practices](https://cloud.google.com/security/best-practices)
- [GitHub Security Features](https://docs.github.com/en/code-security)