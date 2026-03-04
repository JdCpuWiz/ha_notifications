#!/usr/bin/env bash
# NZBGet Post-Processing Extension Script
# Fires a webhook to Home Assistant when a download completes.
#
# Setup:
#   1. Place this file in your NZBGet scripts directory
#   2. In NZBGet: Settings > Extension Scripts > enable this script
#   3. Set NZBGET_EVENT = "NZB_ADDED", "NZB_DOWNLOADED", or "NZB_DELETED"
#
# NZBGet passes results via environment variables:
#   NZBPP_NZBNAME    - NZB name
#   NZBPP_CATEGORY   - Category
#   NZBPP_TOTALSTATUS - SUCCESS / FAILURE / WARNING / DELETED / NONE

HA_WEBHOOK_URL="http://192.168.7.170:8123/api/webhook/nzbget_alert"

STATUS="${NZBPP_TOTALSTATUS:-NONE}"
NZBNAME="${NZBPP_NZBNAME:-Unknown}"
CATEGORY="${NZBPP_CATEGORY:-}"
MESSAGE="${NZBPP_SCRIPTSTATUS:-}"

curl -s -X POST "$HA_WEBHOOK_URL" -H "Content-Type: application/json" -d "{\"status\":\"$STATUS\",\"nzbname\":\"$NZBNAME\",\"category\":\"$CATEGORY\",\"message\":\"$MESSAGE\"}"
