# Security Policy

## Supported Versions

The following versions of gcp-mcp-server are currently being supported with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of gcp-mcp-server seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Please do NOT report security vulnerabilities through public GitHub issues.

Instead, please report them via email to: **security@example.com** (replace with actual security email)

You should receive a response within 48 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

Please include the following information in your report:

- **Type of issue** (e.g. buffer overflow, SQL injection, cross-site scripting, etc.)
- **Full paths of source file(s) related to the manifestation of the issue**
- **The location of the affected source code** (tag/branch/commit or direct URL)
- **Any special configuration required to reproduce the issue**
- **Step-by-step instructions to reproduce the issue**
- **Proof-of-concept or exploit code** (if possible)
- **Impact of the issue**, including how an attacker might exploit the issue

This information will help us triage your report more quickly.

### Preferred Languages

We prefer all communications to be in English.

## Security Best Practices for Users

When using gcp-mcp-server, please follow these security best practices:

### 1. Credential Management
- **Never commit GCP service account keys** to version control
- Use **Application Default Credentials (ADC)** when possible
- Implement **Workload Identity** for GKE deployments
- **Rotate service account keys** regularly (recommended: every 90 days)
- Use **short-lived tokens** instead of long-lived keys when possible

### 2. Access Control
- Follow the **principle of least privilege** for service accounts
- Use **IAM conditions** to restrict access by time, IP, or resource
- Implement **VPC Service Controls** for data exfiltration prevention
- Enable **audit logging** for all API calls
- Use **organization policies** to enforce security constraints

### 3. Network Security
- Use **private Google Access** for VM instances without external IPs
- Implement **firewall rules** to restrict network access
- Enable **VPC Flow Logs** for network monitoring
- Use **Cloud NAT** for outbound internet access from private instances

### 4. Data Protection
- **Encrypt data at rest** using Cloud KMS
- Use **customer-managed encryption keys (CMEK)** for sensitive data
- Implement **data loss prevention (DLP)** scanning
- Enable **VPC Service Controls** for data perimeter security
- Use **signed URLs** with appropriate expiration times

### 5. Monitoring and Alerting
- Enable **Cloud Security Command Center** for security insights
- Set up **budget alerts** to detect unusual usage patterns
- Monitor **audit logs** for suspicious activity
- Implement **anomaly detection** for API usage
- Use **Cloud Asset Inventory** for resource monitoring

### 6. Development Security
- Use **dependency scanning** tools (e.g., pip-audit, safety)
- Implement **code scanning** with tools like CodeQL or Semgrep
- Use **pre-commit hooks** for security checks
- Run **container vulnerability scanning** for Docker images
- Enable **secrets scanning** in CI/CD pipelines

### 7. Configuration Security
- **Pin dependency versions** to avoid supply chain attacks
- Use **integrity checking** for downloaded packages
- Implement **least privilege** for CI/CD service accounts
- Use **separate environments** for development, staging, and production
- Store **configuration securely** using Secret Manager

## Security Features in gcp-mcp-server

### Built-in Security Controls
- **Input validation** for all API parameters
- **Rate limiting** to prevent abuse
- **Request size limits** to prevent DoS attacks
- **Timeout controls** to prevent resource exhaustion
- **Error handling** that doesn't leak sensitive information

### Secure Defaults
- **Minimal IAM permissions** in examples
- **Encrypted connections** (TLS) for all GCP API calls
- **No default credentials** in configuration files
- **Secure random generation** for temporary resources
- **Audit logging enabled** by default where applicable

## Compliance and Standards

gcp-mcp-server aims to align with the following security standards:

- **OWASP Top 10** - Web application security risks
- **NIST Cybersecurity Framework** - Security controls and practices
- **CIS Controls** - Critical security controls
- **ISO 27001** - Information security management
- **SOC 2 Type II** - Security, availability, and confidentiality

## Security Updates

Security updates will be released as patch versions and will be announced:

1. **GitHub Security Advisories** - For vulnerability disclosures
2. **Release Notes** - For security-related changes
3. **Email notifications** - For critical security updates (if subscribed)

## Contact

For security-related questions or concerns, please contact:
- **Email**: security@example.com (replace with actual email)
- **GPG Key**: Available upon request for encrypted communications

## Acknowledgments

We appreciate the security research community and will acknowledge researchers who responsibly disclose vulnerabilities (with their permission).