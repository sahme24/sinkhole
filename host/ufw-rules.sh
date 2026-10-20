#!/usr/bin/env bash
# Homeserver firewall (reference). Run once, review with: sudo ufw status verbose
set -euo pipefail

sudo ufw default deny incoming
sudo ufw default allow outgoing

# Admin access only from the lab desktop
sudo ufw allow from 10.20.0.101 to any port 22 proto tcp
sudo ufw allow from 10.20.0.101 to any port 80 proto tcp

# DNS for the whole network (AdGuard Home)
sudo ufw allow 53

# k3s pod network: pods must reach AdGuard (host service) and each other
sudo ufw allow from 10.42.0.0/16
sudo ufw allow from 10.42.0.0/16 to any port 80 proto tcp
sudo ufw route allow from 10.42.0.0/16
sudo ufw route allow to 10.42.0.0/16

sudo ufw enable
