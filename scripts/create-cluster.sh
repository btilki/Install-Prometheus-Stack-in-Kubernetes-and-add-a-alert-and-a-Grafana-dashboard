#!/usr/bin/env bash
set -euo pipefail
# Exit on error (-e), undefined vars (-u), and fail on pipeline errors (-o pipefail)

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Determine the directory where the script is located

CFG="${DIR}/../eksctl/create-cluster.yaml"
# Path to the EKS cluster configuration file

if ! command -v eksctl >/dev/null 2>&1; then
  echo "eksctl not found. Install from https://eksctl.io/"
  exit 1
fi
# Ensure eksctl is installed

if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl not found. Install from https://kubernetes.io/docs/tasks/tools/"
  exit 1
fi
# Ensure kubectl is installed

echo "Creating EKS cluster using config: ${CFG}"
eksctl create cluster -f "${CFG}"
# Create the EKS cluster using the specified config file

echo
echo "Cluster create initiated (or completed). Please verify with:"
echo "  kubectl get nodes"
# Reminder to verify cluster creation

echo
echo "Next, add Helm repos and install the kube-prometheus-stack chart:"
echo "  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts"
echo "  helm repo update"
echo "  helm install prometheus-stack prometheus-community/kube-prometheus-stack -f helm/values-prometheus.yaml --namespace monitoring --create-namespace"
# Instructions for installing monitoring stack (Prometheus + Grafana) using Helm
