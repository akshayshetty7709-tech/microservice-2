#!/usr/bin/env bash
# Generates ansible/inventory/hosts.ini from Terraform outputs.
# Run from terraform/envs/dev after `terraform apply`.
set -euo pipefail

TF_DIR="$(dirname "$0")/../terraform/envs/dev"
INV_DIR="$(dirname "$0")/../ansible/inventory"
mkdir -p "$INV_DIR"

MASTER_IP=$(terraform -chdir="$TF_DIR" output -raw master_node_ip)
WORKER_IPS=$(terraform -chdir="$TF_DIR" output -json worker_node_ips | jq -r '.[]')

{
  echo "[k8s_master]"
  echo "master ansible_host=${MASTER_IP} ansible_user=ubuntu"
  echo ""
  echo "[k8s_workers]"
  i=0
  for ip in $WORKER_IPS; do
    echo "worker${i} ansible_host=${ip} ansible_user=ubuntu"
    i=$((i+1))
  done
  echo ""
  echo "[k8s_cluster:children]"
  echo "k8s_master"
  echo "k8s_workers"
} > "${INV_DIR}/hosts.ini"

echo "Inventory written to ${INV_DIR}/hosts.ini"
