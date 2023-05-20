#!/bin/bash

# Directory where this script resides
SCRIPT_DIR="$(dirname "$0")"

# Change directory to the script's directory
cd "$SCRIPT_DIR"

# Update package list
opkg update

# Install packages one by one
opkg install bash
opkg install nano-full
opkg install ethtool 
opkg install iptables-nft 
opkg install stubby 
# 
opkg install tailscale 
opkg install luci-app-nlbwmon 
opkg install luci-app-wol 
opkg install ddns-scripts 
opkg install ddns-scripts-cloudflare 
opkg install luci-app-acme

# Sync with remote
git fetch --all
git reset --hard
git pull
