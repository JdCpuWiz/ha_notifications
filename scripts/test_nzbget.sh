#!/usr/bin/env bash
# Test the nzbget_alert webhook
HA="http://192.168.7.170:8123/api/webhook"

echo "--- success (should persistent) ---"
curl -X POST "$HA/nzbget_alert" -H "Content-Type: application/json" -d '{"status":"SUCCESS","nzbname":"Some.Show.S01E01","category":"tv"}'

echo ""
echo "--- failure (should push) ---"
curl -X POST "$HA/nzbget_alert" -H "Content-Type: application/json" -d '{"status":"FAILURE","nzbname":"Some.Show.S01E02","category":"tv","message":"Download failed: missing blocks"}'
