#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-demo}"
RELEASE="${2:-python-demo}"

svc=$(kubectl get svc -n "$NAMESPACE" -l app.kubernetes.io/instance="$RELEASE" -o jsonpath='{.items[0].metadata.name}')
echo "Service: $svc"

kubectl rollout status deploy/"$RELEASE-python-demo" -n "$NAMESPACE" --timeout=120s

pod=$(kubectl get pods -n "$NAMESPACE" -l app.kubernetes.io/instance="$RELEASE" -o jsonpath='{.items[0].metadata.name}')
echo "Pod: $pod"
kubectl exec -n "$NAMESPACE" "$pod" -- wget -qO- http://localhost:8080/healthz
echo
echo "Smoke check OK"
