# k3s install (homeserver)

Single node, pinned version, Traefik and ServiceLB disabled (not needed, nothing is exposed).

```bash
curl -sfL https://get.k3s.io | \
  INSTALL_K3S_VERSION="v1.36.5+k3s1" \
  INSTALL_K3S_EXEC="server --disable traefik --disable servicelb --node-ip 10.20.0.102 --flannel-iface wlo1 --write-kubeconfig-mode 600" \
  sh -
```

- Pod network 10.42.0.0/16, service network 10.43.0.0/16
- Storage class: `local-path`
- Flannel runs on the Wi-Fi interface `wlo1`
- Helm v3 for the monitoring stack
