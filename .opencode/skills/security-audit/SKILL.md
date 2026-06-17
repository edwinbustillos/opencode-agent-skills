---
name: security-audit
description: Expert application security with OWASP Top 10, threat modeling, penetration testing, SAST/DAST, dependency scanning, and security best practices
metadata:
  domains: security,owasp,threat-modeling
  tools: snyk,semgrep
---

## What I do

I identify and remediate security vulnerabilities across the stack:

- **OWASP Top 10**: All current vulnerability categories and mitigations
- **Threat Modeling**: STRIDE, DREAD, attack trees, risk assessment
- **SAST**: Static analysis with Semgrep, SonarQube, CodeQL
- **DAST**: Dynamic analysis with OWASP ZAP, Burp Suite patterns
- **Dependency Scanning**: Snyk, npm audit, Dependabot, OSV
- **Secrets Management**: GitLeaks, detect-secrets, vault integration
- **Code Review**: Security-focused code review checklists
- **Compliance**: SOC 2, GDPR, HIPAA security requirements
- **Authentication**: OAuth2, OIDC, SAML, MFA implementation review
- **Network Security**: TLS configuration, CORS, CSP headers

## When to use me

- Conducting security audits of existing codebases
- Implementing OWASP Top 10 mitigations
- Setting up SAST/DAST in CI/CD pipelines
- Reviewing authentication and authorization implementations
- Designing threat models for new features
- Implementing secrets management
- Conducting code review for security vulnerabilities
- Configuring security headers and CSP

## Best Practices

### OWASP Top 10 Mitigations
1. **Broken Access Control**: Implement RBAC, deny by default, validate permissions server-side
2. **Cryptographic Failures**: Use bcrypt/argon2 for passwords, AES-256 for data at rest, TLS 1.3 for transit
3. **Injection**: Use parameterized queries, ORM query builders, input validation
4. **Insecure Design**: Threat model during design phase, implement defense in depth
5. **Security Misconfiguration**: Harden defaults, remove unnecessary features, update regularly
6. **Vulnerable Components**: Scan dependencies, patch regularly, monitor CVEs
7. **Auth Failures**: Implement MFA, rate limit login attempts, use secure session management
8. **Data Integrity**: Use digital signatures, verify integrity of updates, implement CSP
9. **Logging Failures**: Log security events, protect logs from injection, ensure audit trails
10. **SSRF**: Validate URLs, use allowlists, segment network access

### Code Security
- Never hardcode secrets; use environment variables
- Use parameterized queries; never concatenate SQL
- Validate and sanitize all user inputs server-side
- Implement Content Security Policy headers
- Use `httpOnly` and `secure` flags on cookies
- Implement CSRF protection for state-changing operations
- Use `SameSite=Strict` or `Lax` on session cookies

### Authentication
- Use established libraries (not custom crypto)
- Implement account lockout after failed attempts
- Use secure password hashing (bcrypt, argon2id)
- Implement refresh token rotation
- Use PKCE for OAuth2 flows
- Verify JWT signatures and expiration

### Dependencies
- Run `npm audit` / `pip audit` / `cargo audit` in CI
- Use Snyk or Dependabot for automated PRs
- Pin dependency versions in lock files
- Review transitive dependencies
- Monitor for new CVEs with Snyk monitoring

### CI/CD Security
- Scan code with Semgrep or CodeQL on every PR
- Scan Docker images with Trivy
- Scan secrets with GitLeaks
- Use signed commits and tags
- Implement branch protection rules

## Project Structure

```
security/
├── threat-models/
│   ├── auth-flow.md
│   └── api-threats.md
├── checklists/
│   ├── owasp-top-10.md
│   ├── code-review.md
│   └── deployment.md
├── policies/
│   ├── security-headers.md
│   └── secrets-management.md
├── scans/
│   └── .semgrep.yml             # Custom Semgrep rules
├── scripts/
│   ├── security-scan.sh
│   └── dependency-check.sh
├── .github/
│   └── workflows/
│       └── security.yml         # Security CI pipeline
├── .gitleaks.toml               # GitLeaks config
├── .trivyignore                 # Trivy exclusions
└── docs/
    ├── incident-response.md
    └── security-guidelines.md
```
