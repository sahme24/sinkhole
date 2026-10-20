# Alerting and access

## AdGuard exporter credentials

Run each line on its own so a pasted prompt cannot swallow input.

```bash
read -rp "AdGuard user: " ADG_USER
read -rsp "AdGuard password: " ADG_PASS; echo
kubectl -n monitoring create secret generic adguard-exporter \
  --from-literal=username="$ADG_USER" --from-literal=password="$ADG_PASS"
```

## Grafana alert (Grafana-managed, because the stack's Alertmanager is off)

- Contact point `discord-lab`: Discord webhook, entered in the Grafana UI only
- Rule `Lab target down`, folder `Lab`, group `lab`
  - Query: `probe_success`, condition IS BELOW 1
  - Evaluation every 1m, pending 2m
  - Alert state if no data: Alerting
  - Summary: `{{ $labels.instance }} is down`

## Test the alert

```bash
kubectl -n monitoring scale deploy/blackbox-exporter --replicas=0   # alert fires
kubectl -n monitoring scale deploy/blackbox-exporter --replicas=1   # alert resolves
```

## Reach Grafana (nothing is exposed)

From the admin desktop:

```bash
ssh -L 3000:localhost:3000 <user>@10.20.0.102 \
  "KUBECONFIG=~/.kube/config kubectl -n monitoring port-forward svc/kps-grafana 3000:80"
```

Open http://localhost:3000. Dashboard 20799 shows AdGuard statistics.
