# Python + Docker + AWS EKS – CI/CD Demo

This repo contains:
- A FastAPI app (`app/`)
- Helm chart for Kubernetes (`helm/python-demo`)
- GitHub Actions workflow (`.github/workflows/cicd.yml`) that builds, scans and deploys to **AWS EKS**
- Optional Terraform to create **EKS + ECR + VPC** (`infra/terraform`)
- Post-deploy smoke test script (`k8s/checks/smoke.sh`)

## Quickstart

1. **(Optional) Create infra**

```bash
cd infra/terraform
terraform init
terraform apply -auto-approve
# Note the ECR repo URL output
```

2. **Configure GitHub repository variables/secrets**

- **Repository Variables**: `AWS_REGION` (e.g., `ap-south-1`), `ECR_REPO` (e.g., `python-demo`)
- **Repository Secret**: `AWS_OIDC_ROLE_ARN`, `AWS_ACCOUNT_ID`
- **Repository Variable**: `EKS_CLUSTER` (e.g., `demo-eks`)

The OIDC role should trust `token.actions.githubusercontent.com` and allow: ECR (push), EKS (Describe, UpdateKubeconfig), and minimal permissions for deployment.

3. **Set Helm values**

Edit `helm/python-demo/values.yaml` and set `image.repository` to your ECR repo. The workflow will inject the tag/commit SHA automatically.

4. **Push to `main`**

On push to `main`, the pipeline will:
- Run unit tests
- Lint Dockerfile
- Trivy scan code + image
- Build and push the image to ECR (tagged with commit SHA)
- Deploy/upgrade the Helm release to the EKS cluster

5. **Verify deployment**

```bash
aws eks update-kubeconfig --name <cluster> --region <region>
bash k8s/checks/smoke.sh demo python-demo
```

## Local run

```bash
docker build -f app/Dockerfile -t local/demo .
docker run -p 8080:8080 local/demo
curl localhost:8080
```

## Notes

- Ingress is off by default; enable and configure ALB annotations & domain when needed.
- HPA is enabled; tune the limits/requests per environment.
