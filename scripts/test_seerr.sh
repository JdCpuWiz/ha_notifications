#!/usr/bin/env bash
# Test the seerr_alert webhook (Overseerr/Jellyseerr)
HA="http://192.168.7.170:8123/api/webhook/seerr_alert"

echo "--- media available (push) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"notification_type":"MEDIA_AVAILABLE","subject":"Dune: Part Two","media":{"media_type":"movie"},"request":{"requestedBy_username":"shad"}}'

echo ""
echo "--- media pending (persistent) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"notification_type":"MEDIA_PENDING","subject":"The Bear","media":{"media_type":"tv"},"request":{"requestedBy_username":"shad"}}'

echo ""
echo "--- test ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"notification_type":"TEST_NOTIFICATION","subject":"Test notification","media":{"media_type":""},"request":{"requestedBy_username":"shad"}}'
