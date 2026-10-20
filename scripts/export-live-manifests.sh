#!/usr/bin/env bash
# Export the live objects so the repo matches the cluster. Secrets are not exported.
set -euo pipefail
OUT="${1:-live-export}"
mkdir -p "$OUT"
for kind in deployment service configmap servicemonitor probe; do
  kubectl -n monitoring get "$kind" -l 'app in (adguard-exporter,blackbox-exporter)' -o yaml > "$OUT/$kind.yaml" || true
done
kubectl -n monitoring get probe lab-ping lab-dns -o yaml > "$OUT/probes.yaml"
kubectl -n monitoring get configmap blackbox-config -o yaml > "$OUT/blackbox-config.yaml"
helm -n monitoring get values kps > "$OUT/monitoring-values-live.yaml"
echo "Exported to $OUT. Review for sensitive values before committing."
