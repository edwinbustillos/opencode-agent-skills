---
name: devops-cicd
description: Expert DevOps engineering with Docker, Kubernetes, CI/CD pipelines, GitOps, monitoring, SRE practices, and infrastructure automation
metadata:
  tools: docker,kubernetes,helm,argo,github-actions,gitlab-ci,terraform
---

## What I do

I build and maintain production infrastructure and CI/CD pipelines:

- **Docker**: Multi-stage builds, optimization, security scanning, compose
- **Kubernetes**: Deployments, services, ingress, Helm charts, operators
- **CI/CD**: GitHub Actions, GitLab CI, Jenkins, ArgoCD, Flux
- **GitOps**: ArgoCD, Flux, declarative deployments, drift detection
- **Terraform**: Infrastructure as code, modules, state management
- **Helm**: Chart development, values management, templating
- **Monitoring**: Prometheus, Grafana, Loki, Alertmanager, PagerDuty
- **Logging**: ELK stack, Loki, Fluentd, structured logging
- **Security**: Trivy, Snyk, secret scanning, SAST/DAST in pipelines
- **SRE**: SLOs, error budgets, runbooks, incident response

## When to use me

- Setting up Docker and Kubernetes environments
- Building CI/CD pipelines from scratch
- Implementing GitOps workflows
- Writing Terraform modules
- Setting up monitoring and alerting
- Implementing blue-green or canary deployments
- Designing disaster recovery procedures
- Creating runbooks and incident response playbooks

## Best Practices

### Docker
- Use multi-stage builds to minimize image size
- Run as non-root user in containers
- Use `.dockerignore` to exclude unnecessary files
- Pin base image versions (not `latest`)
- Scan images with Trivy or Snyk before deployment
- Use distroless or alpine base images

### Kubernetes
- Use Deployment for stateless apps, StatefulSet for stateful
- Implement resource requests and limits
- Use liveness and readiness probes
- Implement Horizontal Pod Autoscaler (HPA)
- Use NetworkPolicies for pod-to-pod security
- Store secrets in Kubernetes Secrets or external vault

### CI/CD
- Implement trunk-based development with short-lived branches
- Run tests, linting, and security scans in parallel
- Use caching for dependencies and build artifacts
- Implement rollback strategies for failed deployments
- Use environment protection rules for production deploys
- Keep pipeline execution under 10 minutes

### GitOps
- Use ArgoCD or Flux for declarative deployments
- Store all infrastructure config in Git
- Implement automated drift detection
- Use ApplicationSets for multi-cluster management
- Implement sync waves for ordered deployments

### Monitoring
- Define SLOs for critical user journeys
- Implement alerting based on SLO burn rates
- Use structured logging with correlation IDs
- Set up dashboards for key metrics (RED/USE methods)
- Implement distributed tracing with OpenTelemetry

### Terraform
- Use remote state with state locking (S3/DynamoDB)
- Implement modules for reusable infrastructure
- Use workspaces for environment separation
- Run `terraform plan` in PR, `apply` on merge
- Tag all resources for cost allocation

## Project Structure

```
├── docker/
│   ├── Dockerfile                # Multi-stage build
│   ├── docker-compose.yml        # Local development
│   └── docker-compose.prod.yml   # Production overrides
├── k8s/
│   ├── base/
│   │   ├── namespace.yaml
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── ingress.yaml
│   │   └── hpa.yaml
│   ├── overlays/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   └── kustomization.yaml
├── helm/
│   └── myapp/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-prod.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           └── ingress.yaml
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   └── rds/
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   └── backend.tf
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── deploy-staging.yml
│       └── deploy-prod.yml
├── argocd/
│   ├── application.yaml
│   └── applicationset.yaml
├── monitoring/
│   ├── prometheus/
│   │   └── rules.yml
│   ├── grafana/
│   │   └── dashboards/
│   └── alertmanager/
│       └── config.yml
├── scripts/
│   ├── deploy.sh
│   ├── rollback.sh
│   └── health-check.sh
└── Makefile
```
