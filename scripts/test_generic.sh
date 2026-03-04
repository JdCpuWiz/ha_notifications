#!/usr/bin/env bash
# Test the generic_alert webhook with each severity level
HA="http://192.168.7.170:8123/api/webhook"

echo "--- critical ---"
curl -X POST "$HA/generic_alert" -H "Content-Type: application/json" -d '{"title":"Critical Test","message":"This should push + persistent notification","severity":"critical","source":"test"}'

echo ""
echo "--- warning ---"
curl -X POST "$HA/generic_alert" -H "Content-Type: application/json" -d '{"title":"Warning Test","message":"This should push only","severity":"warning","source":"test"}'

echo ""
echo "--- info ---"
curl -X POST "$HA/generic_alert" -H "Content-Type: application/json" -d '{"title":"Info Test","message":"This should persistent only","severity":"info","source":"test"}'
