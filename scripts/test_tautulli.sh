#!/usr/bin/env bash
# Test the tautulli_alert webhook
HA="http://192.168.7.170:8123/api/webhook/tautulli_alert"

echo "--- play (episode) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"action":"play","user":"shad","media_type":"episode","title":"Ozymandias","grandparent_title":"Breaking Bad","parent_title":"Season 5","player":"Apple TV"}'

echo ""
echo "--- watched (movie) ---"
curl -X POST "$HA" -H "Content-Type: application/json" -d '{"action":"watched","user":"shad","media_type":"movie","title":"The Dark Knight","player":"Apple TV"}'
