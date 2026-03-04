#!/usr/bin/env bash
# Test the arr_alert webhook (Sonarr/Radarr/etc)
HA="http://192.168.7.170:8123/api/webhook/arr_alert"

echo "--- test event ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"eventType":"Test","instanceName":"Sonarr"}'

echo ""
echo "--- health issue ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"eventType":"Health","instanceName":"Radarr","message":"Indexer unavailable: no indexers available"}'

echo ""
echo "--- download (episode) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"eventType":"Download","instanceName":"Sonarr","series":{"title":"Breaking Bad"},"isUpgrade":false}'

echo ""
echo "--- download (movie upgrade) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"eventType":"Download","instanceName":"Radarr","movie":{"title":"Inception"},"isUpgrade":true}'
