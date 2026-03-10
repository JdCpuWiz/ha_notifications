#!/bin/bash
# Bond health monitor — sends webhook to Home Assistant on state change only.
# Deploy to each Proxmox node at /usr/local/bin/bond-monitor.sh
# Run via cron every minute: * * * * * /usr/local/bin/bond-monitor.sh

HA_WEBHOOK="http://192.168.7.170:8123/api/webhook/proxmox_alert"
BOND_IF="bond0"
BOND_FILE="/proc/net/bonding/$BOND_IF"
STATE_FILE="/var/lib/bond-monitor/state"
EXPECTED_PORTS=2
SOURCE="$(hostname)"

mkdir -p "$(dirname "$STATE_FILE")"

# Nothing to do if bond interface doesn't exist on this node
[ -f "$BOND_FILE" ] || exit 0

ACTIVE=$(grep "Number of ports:" "$BOND_FILE" | awk '{print $NF}')

# Guard against empty parse result
if [ -z "$ACTIVE" ]; then
    exit 0
fi

PREV_STATE="$(cat "$STATE_FILE" 2>/dev/null || echo "OK")"

if [ "$ACTIVE" -lt "$EXPECTED_PORTS" ]; then
    CURRENT_STATE="DEGRADED"
else
    CURRENT_STATE="OK"
fi

# Only fire on state change to avoid alert floods
[ "$CURRENT_STATE" = "$PREV_STATE" ] && exit 0

echo "$CURRENT_STATE" > "$STATE_FILE"

if [ "$CURRENT_STATE" = "DEGRADED" ]; then
    TITLE="bond0 degraded"
    MSG="Only ${ACTIVE} of ${EXPECTED_PORTS} links active on ${SOURCE}"
    SEVERITY="error"
else
    TITLE="bond0 recovered"
    MSG="All ${EXPECTED_PORTS} links active on ${SOURCE}"
    SEVERITY="info"
fi

curl -s -X POST "$HA_WEBHOOK" -H "Content-Type: application/json" -d "{\"title\":\"$TITLE\",\"message\":\"$MSG\",\"severity\":\"$SEVERITY\",\"source\":\"$SOURCE\"}"
