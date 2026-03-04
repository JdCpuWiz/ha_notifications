#!/usr/bin/env bash
# SABnzbd Post-Processing Notification Script
# Fires a webhook to Home Assistant on download completion.
#
# Setup:
#   1. Place this file somewhere accessible (e.g. /opt/scripts/sabnzbd_notify.sh)
#   2. Make it executable: chmod +x sabnzbd_notify.sh
#   3. In SABnzbd: Config > Notifications > Script notifications > select this script
#
# SABnzbd passes job info via environment variables:
#   SAB_FINAL_NAME  - Final job name
#   SAB_CAT         - Category
#   SAB_STATUS      - 0 = completed, 1 = failed

HA_WEBHOOK_URL="http://192.168.7.170:8123/api/webhook/sabnzbd_alert"

NZBNAME="${SAB_FINAL_NAME:-${SAB_FILENAME:-Unknown}}"
CATEGORY="${SAB_CAT:-}"
RAW_STATUS="${SAB_STATUS:-0}"

if [ "$RAW_STATUS" = "1" ]; then
  STATUS="failed"
else
  STATUS="completed"
fi

curl -s -X POST "$HA_WEBHOOK_URL" -H "Content-Type: application/json" -d "{\"status\":\"$STATUS\",\"nzbname\":\"$NZBNAME\",\"category\":\"$CATEGORY\"}"
