#!/usr/bin/env bash
# Test the speedtest_alert webhook
# Note: only fires if values are below threshold (100 down / 20 up)
HA="http://192.168.7.170:8123/api/webhook"

echo "--- slow speeds (should notify) ---"
curl -X POST "$HA/speedtest_alert" -H "Content-Type: application/json" -d '{"data":{"download":45.2,"upload":8.1,"ping":22.5,"server_name":"Test Server"}}'

echo ""
echo "--- good speeds (should NOT notify) ---"
curl -X POST "$HA/speedtest_alert" -H "Content-Type: application/json" -d '{"data":{"download":450.0,"upload":50.0,"ping":12.0,"server_name":"Test Server"}}'
