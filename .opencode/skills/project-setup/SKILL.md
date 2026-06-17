---
name: project-setup
description: Expert project scaffolding and setup for any language/framework with proper structure, tooling, CI/CD, and best practices
metadata:
  scope: universal
  level: expert
---

## What I do

I scaffold production-ready projects with proper tooling and structure:

- **Project Initialization**: Choose stack, initialize repos, configure tooling
- **TypeScript/Node.js**: Vite, Next.js, NestJS, Express project scaffolding
- **Python**: FastAPI, Django, Flask with Poetry/uv, ruff, mypy
- **Go**: Module init, project layout, Makefile, golangci-lint
- **Rust**: Cargo workspace, axum/actix templates, clippy config
- **Tooling**: Git hooks, linting, formatting, editorconfig, pre-commit
- **CI/CD**: GitHub Actions, GitLab CI pipeline templates
- **Docker**: Dockerfile, docker-compose for local development
- **Documentation**: README templates, CONTRIBUTING.md, API docs
- **Security**: .env templates, .gitignore, secret scanning

## When to use me

- Starting a new project from scratch
- Setting up a monorepo structure
- Configuring linting and formatting tools
- Creating CI/CD pipeline templates
- Setting up Docker for development
- Creating project documentation templates
- Migrating between build tools
- Standardizing project structure across teams

## Best Practices

### Repository Setup
- Initialize git with `.gitignore`, `.editorconfig`
- Set up branch protection rules
- Add LICENSE file
- Create CONTRIBUTING.md with guidelines
- Configure commitlint for conventional commits
- Set up husky + lint-staged for pre-commit hooks

### Tooling Checklist
- [ ] Linter configured (ESLint, ruff, golangci-lint, clippy)
- [ ] Formatter configured (Prettier, black, gofmt, rustfmt)
- [ ] EditorConfig for cross-editor consistency
- [ ] Pre-commit hooks (lint, format, type-check)
- [ ] CI pipeline (lint, test, build, deploy)
- [ ] Dependabot/Renovate for dependency updates
- [ ] Secret scanning (GitLeaks, detect-secrets)

### Development Environment
- Docker Compose for local services (DB, Redis, etc.)
- Environment variable template (.env.example)
- Makefile or justfile for common commands
- README with setup instructions
- VS Code workspace settings and extensions

### Documentation
- README.md: Project overview, setup, usage, contributing
- API documentation (OpenAPI/Swagger for REST, GraphQL schema)
- Architecture decision records (ADRs) for major decisions
- CHANGELOG.md for version history
- Code of Conduct

## Project Structure

```
myproject/
├── src/
│   └── (project source code)
├── tests/
│   └── (test files)
├── docs/
│   ├── architecture.md
│   ├── adr/
│   │   └── 001-framework-choice.md
│   └── api/
├── scripts/
│   ├── setup.sh                 # First-time setup
│   ├── dev.sh                   # Start development
│   └── build.sh                 # Production build
├── docker/
│   ├── Dockerfile               # Multi-stage build
│   ├── docker-compose.yml       # Local dev services
│   └── docker-compose.prod.yml
├── .github/
│   ├── workflows/
│   │   ├── ci.yml
│   │   └── release.yml
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── dependabot.yml
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   └── launch.json
├── .gitignore
├── .editorconfig
├── .env.example
├── .gitleaks.toml
├── Makefile
├── README.md
├── CONTRIBUTING.md
├── LICENSE
├── CHANGELOG.md
├── package.json                 # Node.js projects
├── pyproject.toml               # Python projects
├── go.mod                       # Go projects
├── Cargo.toml                   # Rust projects
└── Dockerfile
```
