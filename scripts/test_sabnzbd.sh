#!/usr/bin/env bash
# Test the sabnzbd_alert webhook
HA="http://192.168.7.170:8123/api/webhook"

echo "--- success (should persistent) ---"
curl -X POST "$HA/sabnzbd_alert" -H "Content-Type: application/json" -d '{"status":"completed","nzbname":"Some.Movie.2024","category":"movies"}'

echo ""
echo "--- failure (should push) ---"
curl -X POST "$HA/sabnzbd_alert" -H "Content-Type: application/json" -d '{"status":"failed","nzbname":"Some.Movie.2025","category":"movies","message":"Repair failed"}'
