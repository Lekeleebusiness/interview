# Cardmarket DevOps Technical Assessment

This repository contains my solution for the DevOps Engineer technical assessment.

The project demonstrates the end-to-end process of containerizing a simple application, automating its build and release, and deploying it to a local Kubernetes cluster using modern DevOps practices including CI/CD, GitOps, Infrastructure as Code, and Semantic Versioning.

---

# Solution Overview

This solution demonstrates the following:

- Build a custom Docker image
- Automatically publish Docker images to Docker Hub
- Automatic Semantic Versioning
- Automatic CHANGELOG generation
- Kubernetes deployment using Helm
- GitOps deployment using Argo CD
- Infrastructure as Code using Terraform
- Shell script review
- Kubernetes deployment manifest review

---

# Architecture

```text
                    Developer
                        │
                        ▼
               GitHub Repository
                        │
                        ▼
              GitHub Actions CI/CD
                        │
        ┌───────────────┴────────────────┐
        │                                │
        ▼                                ▼
 Build & Push Docker Image        Release Please
        │                    (SemVer + CHANGELOG)
        │
        ▼
 Update Helm values.yaml
        │
        ▼
 Git Repository (Desired State)
        │
        ▼
      Argo CD
        │
        ▼
 Kubernetes Cluster (Minikube)
        │
 ┌──────┴────────┐
 │               │
Deployment    Service
 

```

---

# Repository Structure

```text
.
├── CHANGELOG.md              # Automatically generated release notes
├── README.md                 # Project documentation
│
├── app/                      # Node.js application and Dockerfile
│
├── argocd/                   # Argo CD application manifests
│
├── configs/                  # Configuration files
│
├── helm/                     # Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│
├── k8s/                      # Raw Kubernetes manifests
│
├── screenshot/               # Deployment screenshots
│
├── shell/                    # Shell script and deployment review
│
└── terraform/                # Infrastructure as Code
```

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| Node.js | Sample application |
| Docker | Containerization |
| GitHub Actions | Continuous Integration |
| Docker Hub | Container Registry |
| Kubernetes | Container Orchestration |
| Helm | Kubernetes Package Management |
| Minikube | Local Kubernetes Cluster |
| NGINX Ingress Controller | Ingress Management |
| Argo CD | GitOps Continuous Deployment |
| Terraform | Infrastructure as Code |
| Release Please | Semantic Versioning & CHANGELOG |

---

# Application

The application is intentionally simple.

It exposes a single HTTP endpoint returning:

```text
Hello from Kubernetes!
```

The goal of the assessment is to demonstrate deployment automation and platform engineering practices rather than application complexity.

---

# Containerization

The application is packaged using a custom Dockerfile.

GitHub Actions automatically builds and publishes Docker images to Docker Hub.

Each release produces two image tags.

Semantic Version

```text
1.0.0
```

Commit SHA

```text
6a1a33ea46f63a2c3896a3baf5ce67cd47739b06
```

Using both tags provides:

- Human-readable release versions
- Immutable traceability back to the exact source code

---

# Continuous Integration

GitHub Actions automates the following tasks:

- Build Docker image
- Push Docker image to Docker Hub
- Generate Semantic Version
- Generate CHANGELOG.md
- Update Helm image tag

---

# Semantic Versioning

This project uses **Release Please** together with **Conventional Commits**.

Example commit messages:

```text
feat: add ingress configuration

fix: correct service selector

docs: update README
```

Release Please automatically:

- Calculates the next semantic version
- Creates GitHub Releases
- Generates release notes
- Updates CHANGELOG.md

---

# Kubernetes Deployment

The application is deployed using Helm.

The deployment creates the following Kubernetes resources:

- Namespace
- Deployment
- Service
- Ingress

The Helm chart provides a reusable and configurable deployment mechanism.

---

# GitOps

Argo CD continuously monitors this Git repository.

Whenever the Helm manifests are updated, Argo CD automatically synchronizes the Kubernetes cluster with the desired state stored in Git.

This provides:

- Declarative deployments
- Version-controlled infrastructure
- Automatic synchronization
- Easy rollback using Git history

---

# Infrastructure as Code

Terraform has been included as an optional enhancement to demonstrate Infrastructure as Code principles.

Although this assessment targets a local Kubernetes cluster, Terraform demonstrates how infrastructure can be managed declaratively and version controlled.

---

# Prerequisites

The following tools are required to run this project:

- Docker
- Git
- kubectl
- Helm
- Minikube

---

# Running the Project

## Clone Repository

```bash
git clone https://github.com/Lekeleebusiness/interview.git

cd interview
```

---

## Start Minikube

```bash
minikube start
```

Enable the Ingress Controller

```bash
minikube addons enable ingress
```

---

## Deploy the Application

```bash
helm upgrade --install cardmarket ./helm
```

---

## Verify the Deployment

```bash
kubectl get all -n cardmarket

kubectl get ingress -n cardmarket
```

---

## Access the Application

Retrieve the Minikube IP.

```bash
minikube ip
```

Add the following entry to your hosts file.

```text
<MINIKUBE_IP> cardmarket.local
```

Then access the application.

```text
http://cardmarket.local
```

---

# Screenshots

The repository includes screenshots demonstrating the completed deployment.

| Screenshot | Description |
|------------|-------------|
| 01-helm-install-success.png | Successful Helm deployment |
| 02-kubernetes-resources.png | Deployment, Service and Ingress |
| 03-pod-running-and-logs.png | Running application pod |
| 04-application-browser.png | Application accessible through Ingress |
| 05-argocd-overview.png | Argo CD application overview |
| 06-argocd-resource-tree.png | Argo CD resource topology |

---

# Code Review

The assessment also included code review tasks.

The repository contains reviews for:

- Shell Script
- Kubernetes Deployment Manifest

Each review includes:

- Identified issues
- Technical explanation
- Potential impact
- Recommended solution
- Corrected implementation

---

# Design Decisions

## Why Minikube?

Minikube was selected because it provides a lightweight local Kubernetes cluster that closely resembles a production environment while remaining simple to install and use. It also provides built-in support for the NGINX Ingress Controller.

---

## Why Helm?

Helm simplifies Kubernetes deployments by packaging Kubernetes manifests into reusable templates. Configuration is managed through `values.yaml`, making deployments easier to maintain and customize.

---

## Why Argo CD?

Argo CD enables GitOps by continuously synchronizing the Kubernetes cluster with the desired state stored in Git. This removes manual deployment steps and ensures Git remains the single source of truth.

---

## Why GitHub Actions?

GitHub Actions integrates directly with the repository and automates Docker image builds, releases, and deployment updates without requiring additional CI infrastructure.

---

## Why Semantic Versioning?

Semantic Versioning provides predictable and meaningful release versions, making it easier to understand the impact of changes than using commit SHA tags alone.

---

## Why Release Please?

Release Please automates release management by:

- Generating semantic versions
- Creating GitHub Releases
- Maintaining CHANGELOG.md
- Producing release notes from Conventional Commits

---

# Future Improvements

If this project were intended for production, I would additionally implement:

- Horizontal Pod Autoscaler (HPA)
- Resource Requests and Limits
- Readiness Probes
- Liveness Probes
- TLS using cert-manager
- External Secrets
- Container image vulnerability scanning
- Prometheus and Grafana monitoring
- Centralized logging
- Deploy to a managed Kubernetes service such as Amazon EKS, Azure AKS, or Google GKE

---

# Assessment Requirements

| Requirement | Status |
|------------|--------|
| Local Kubernetes Cluster | ✅ |
| Dockerized Application | ✅ |
| Dockerfile created manually | ✅ |
| Automatic Image Build | ✅ |
| Automatic Image Publishing | ✅ |
| Kubernetes Deployment | ✅ |
| Helm | ✅ |
| GitHub Actions CI/CD | ✅ |
| GitOps | ✅ |
| Argo CD | ✅ |
| Infrastructure as Code | ✅ |
| Semantic Versioning | ✅ |
| Automatic CHANGELOG | ✅ |
| Shell Script Review | ✅ |
| Kubernetes Manifest Review | ✅ |

---

# Author

**Oluwaleke Oladeji**



