#!/usr/bin/env bash
# Test the dockmon_alert webhook
HA="http://192.168.7.170:8123/api/webhook"

echo "--- container down ---"
curl -X POST "$HA/dockmon_alert" -H "Content-Type: application/json" -d '{"title":"Dockmon Alert","message":"Container plex is down"}'

echo ""
echo "--- container up ---"
curl -X POST "$HA/dockmon_alert" -H "Content-Type: application/json" -d '{"title":"Dockmon Alert","message":"Container plex is back up"}'
