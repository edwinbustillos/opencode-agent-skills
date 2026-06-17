---
name: cloud-aws
description: Expert AWS cloud architecture with EC2, ECS, Lambda, RDS, S3, DynamoDB, CloudFront, IAM, Terraform, and Well-Architected Framework
metadata:
  provider: aws
  services: ec2,ecs,lambda,rds,s3,dynamodb
  iac: terraform,cdk
---

## What I do

I design and implement production-grade AWS architectures:

- **Compute**: ECS Fargate, Lambda, EC2 Auto Scaling, EKS
- **Database**: RDS Aurora, DynamoDB, ElastiCache, DocumentDB
- **Storage**: S3, EFS, EBS with lifecycle policies
- **Networking**: VPC design, ALB/NLB, CloudFront, Route 53
- **Security**: IAM policies, KMS, Secrets Manager, WAF, Shield
- **Serverless**: Lambda, API Gateway, Step Functions, SQS/SNS
- **IaC**: Terraform (preferred), AWS CDK, CloudFormation
- **Monitoring**: CloudWatch, X-Ray, CloudTrail, Config
- **CI/CD**: CodePipeline, CodeBuild, CodeDeploy, GitHub Actions
- **Cost**: Reserved Instances, Savings Plans, Spot, Cost Explorer

## When to use me

- Designing AWS architectures for new applications
- Migrating on-premises workloads to AWS
- Implementing infrastructure as code with Terraform
- Setting up ECS Fargate or Lambda deployments
- Designing VPC and networking topologies
- Implementing CI/CD pipelines on AWS
- Optimizing AWS costs
- Implementing disaster recovery strategies

## Best Practices

### Well-Architected Framework
- Design for failure; use multi-AZ deployments
- Implement auto-scaling for all compute resources
- Use managed services when possible (RDS, ElastiCache)
- Design stateless applications for horizontal scaling
- Implement health checks for all services

### Security
- Apply least privilege principle to all IAM policies
- Use IAM roles, not access keys, for EC2/ECS/Lambda
- Encrypt data at rest (KMS) and in transit (TLS)
- Use Secrets Manager for database credentials
- Enable CloudTrail for audit logging
- Use WAF for web application protection

### Cost Optimization
- Right-size instances with Cost Explorer recommendations
- Use Spot Instances for fault-tolerant workloads
- Implement S3 lifecycle policies for cost reduction
- Use Reserved Instances or Savings Plans for predictable workloads
- Monitor with AWS Budgets and Cost Explorer

### Networking
- Use VPC with public/private subnet separation
- Deploy across multiple AZs for high availability
- Use ALB for HTTP/HTTPS, NLB for TCP/UDP
- Implement VPC endpoints for AWS service access
- Use CloudFront for static content and API caching

### Serverless
- Use Lambda for event-driven, short-running tasks
- Implement dead letter queues for failed invocations
- Use Step Functions for complex workflows
- Optimize Lambda memory (affects CPU and cost)
- Use API Gateway caching for read-heavy APIs

## Project Structure

```
infrastructure/
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── terraform.tfvars
│   │   ├── staging/
│   │   └── prod/
│   ├── modules/
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── ecs/
│   │   ├── rds/
│   │   ├── lambda/
│   │   └── s3/
│   └── shared/
│       └── backend.tf
├── ecs/
│   ├── task-definitions/
│   ├── services/
│   └── clusters/
├── lambda/
│   ├── functions/
│   └── layers/
├── scripts/
│   ├── deploy.sh
│   └── destroy.sh
├── .github/
│   └── workflows/
│       └── deploy.yml
└── docker/
    └── Dockerfile
```
