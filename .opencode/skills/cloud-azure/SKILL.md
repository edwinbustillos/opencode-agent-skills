---
name: cloud-azure
description: Expert Azure cloud architecture with AKS, Azure Functions, Cosmos DB, Azure SQL, Blob Storage, Entra ID, Bicep, and Well-Architected Framework
metadata:
  provider: azure
  services: aks,functions,cosmos-db,azure-sql
  iac: bicep,terraform
---

## What I do

I design and implement production-grade Azure architectures:

- **Compute**: AKS, Azure Functions, App Service, Container Instances
- **Database**: Azure SQL, Cosmos DB, Azure Database for PostgreSQL/MySQL
- **Storage**: Blob Storage, File Storage, Queue Storage, Table Storage
- **Networking**: VNet, Azure Front Door, Application Gateway, Traffic Manager
- **Security**: Entra ID, Key Vault, Managed Identities, Azure Policy
- **Serverless**: Azure Functions, Durable Functions, Logic Apps
- **IaC**: Bicep (preferred), Terraform, ARM templates
- **Monitoring**: Azure Monitor, Application Insights, Log Analytics
- **CI/CD**: Azure DevOps, GitHub Actions, Azure Pipelines
- **Messaging**: Event Hubs, Service Bus, Event Grid, SignalR

## When to use me

- Designing Azure architectures for new applications
- Migrating workloads to Azure (lift-and-shift or re-architecture)
- Implementing infrastructure as code with Bicep
- Setting up AKS clusters
- Implementing Azure Functions serverless architectures
- Designing multi-region disaster recovery
- Implementing Azure DevOps CI/CD pipelines
- Configuring Azure security and compliance

## Best Practices

### Well-Architected Framework
- Design for availability (SLAs), resilience, and scalability
- Use availability zones for high availability
- Implement auto-scaling for App Service and AKS
- Use Azure Front Door for global load balancing
- Design stateless applications for horizontal scaling

### Security
- Use Managed Identities for service authentication
- Store secrets in Key Vault with RBAC access policies
- Implement Azure Policy for compliance guardrails
- Enable Microsoft Defender for Cloud
- Use Private Endpoints for PaaS services
- Enable Azure AD Conditional Access

### Cost Optimization
- Use Azure Advisor for cost recommendations
- Implement auto-shutdown for dev/test VMs
- Use Azure Reservations for predictable workloads
- Right-size with Azure Monitor metrics
- Use Azure Cost Management for budgeting

### Networking
- Use VNet with subnet segmentation
- Implement NSGs for network security
- Use Azure Front Door for global routing
- Implement Private Link for secure PaaS access
- Use Azure DNS for domain management

### Data & Storage
- Use Cosmos DB with multi-region writes for global apps
- Implement Blob Storage lifecycle management
- Use Azure SQL elastic pools for multi-tenant apps
- Enable transparent data encryption
- Implement geo-redundant storage for DR

## Project Structure

```
infrastructure/
├── bicep/
│   ├── main.bicep
│   ├── modules/
│   │   ├── vnet.bicep
│   │   ├── aks.bicep
│   │   ├── sql.bicep
│   │   ├── function-app.bicep
│   │   └── key-vault.bicep
│   ├── parameters/
│   │   ├── dev.bicepparam
│   │   ├── staging.bicepparam
│   │   └── prod.bicepparam
│   └── what-if/
├── terraform/
│   ├── environments/
│   └── modules/
├── aks/
│   ├── helm-values/
│   ├── ingress/
│   └── monitoring/
├── functions/
│   ├── http-trigger/
│   ├── queue-trigger/
│   └── timer-trigger/
├── pipelines/
│   ├── azure-pipelines.yml
│   └── templates/
├── scripts/
│   ├── deploy.sh
│   └── teardown.sh
├── .github/
│   └── workflows/
│       └── deploy.yml
└── docker/
    └── Dockerfile
```
