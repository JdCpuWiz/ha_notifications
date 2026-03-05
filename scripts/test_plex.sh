#!/usr/bin/env bash
# Test the plex_alert webhook (direct Plex webhooks, multipart/form-data)
HA="http://192.168.7.170:8123/api/webhook"

PAYLOAD='{"event":"media.play","Account":{"title":"testuser"},"Player":{"title":"Apple TV"},"Metadata":{"type":"episode","title":"Pilot","grandparentTitle":"Some Show"}}'

echo "--- media.play (should persistent) ---"
curl -X POST "$HA/plex_alert" -F "payload=$PAYLOAD"

echo ""
PAYLOAD2='{"event":"media.scrobble","Account":{"title":"testuser"},"Player":{"title":"Apple TV"},"Metadata":{"type":"movie","title":"Some Movie","grandparentTitle":""}}'

echo "--- media.scrobble (should persistent) ---"
curl -X POST "$HA/plex_alert" -F "payload=$PAYLOAD2"
