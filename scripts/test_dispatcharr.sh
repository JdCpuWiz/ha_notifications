#!/usr/bin/env bash
# Test the dispatcharr_alert webhook
HA="http://192.168.7.170:8123/api/webhook"

echo "--- warning (should push) ---"
curl -X POST "$HA/dispatcharr_alert" -H "Content-Type: application/json" -d '{"title":"Stream Issue","message":"Stream quality degraded","severity":"warning"}'

echo ""
echo "--- info (should persistent) ---"
curl -X POST "$HA/dispatcharr_alert" -H "Content-Type: application/json" -d '{"title":"Stream Started","message":"User connected to stream","severity":"info"}'
