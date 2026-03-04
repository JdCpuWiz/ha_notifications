#!/usr/bin/env bash
# Test the proxmox_alert webhook
HA="http://192.168.7.170:8123/api/webhook/proxmox_alert"

echo "--- info: backup success ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"title":"Backup successful","message":"VM 100 (ubuntu) backup finished successfully","severity":"info","source":"pve1"}'

echo ""
echo "--- warning ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"title":"High memory usage","message":"Node pve2 memory usage at 85%","severity":"warning","source":"pve2"}'

echo ""
echo "--- error (maps to critical) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"title":"Storage failure","message":"ZFS pool degraded on pve3","severity":"error","source":"pve3"}'
