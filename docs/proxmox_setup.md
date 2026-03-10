# Proxmox Setup

Proxmox 9.x has a built-in notification system with native webhook support.
Configure each of your 3 nodes separately — use the `source` field to identify them.

> **Note:** PVE 9 uses Handlebars templates. Do NOT include `message` in the body template —
> Proxmox notification messages contain newlines which break JSON parsing in HA.
> Title + severity is sufficient.

## Webhook Endpoint (per node)

**Datacenter > Notifications > Endpoints > Add > Webhook**

| Field  | Value |
|--------|-------|
| Name   | `homeassistant` |
| URL    | `http://192.168.7.170:8123/api/webhook/proxmox_alert` |
| Method | POST |

**Headers:**
```
Content-Type: application/json
```

**Body template** (adjust `source` per node — omit `message` due to Handlebars/newline issue):

- pve: `{"title":"{{title}}","severity":"{{severity}}","source":"pve"}`
- pve2: `{"title":"{{title}}","severity":"{{severity}}","source":"pve2"}`
- pve3: `{"title":"{{title}}","severity":"{{severity}}","source":"pve3"}`

## Notification Matcher

**Datacenter > Notifications > Matchers > Add**

- Match all severities: info, warning, error
- Target: `homeassistant`
- Apply to: all notification types (or filter as needed)

## Severity Mapping

The HA automation automatically maps Proxmox severities:
- `info` → persistent HA notification
- `warning` → iOS push
- `error` → iOS push (critical, bypasses Do Not Disturb) + persistent notification

## Notification Types Covered

- Backup jobs (success and failure)
- Replication jobs
- Package updates
- Storage / ZFS alerts
- System mail (SMART failures, etc.)

---

## Bond Interface Health Monitoring

The Proxmox notification system does not watch network bond state, so a separate
cron script handles this.  It reads `/proc/net/bonding/bond0`, tracks state in a
file, and only fires on a **state change** (degraded → OK or OK → degraded) so
you never get a flood of repeated alerts.

### Deploy the script (on each PVE node)

```bash
scp scripts/proxmox_bond_monitor.sh root@pve:/usr/local/bin/bond-monitor.sh
ssh root@pve chmod +x /usr/local/bin/bond-monitor.sh
```

Repeat for `pve2`, `pve3`.

### Add the cron job (on each node)

```bash
(crontab -l 2>/dev/null; echo "* * * * * /usr/local/bin/bond-monitor.sh") | crontab -
```

### How it works

| Event | Severity | Result |
|-------|----------|--------|
| Link count drops below 2 | `error` | iOS critical push + persistent HA notification |
| Bond fully recovers | `info` | Persistent HA notification only |

State is persisted in `/var/lib/bond-monitor/state` so only transitions are
notified, not every cron tick.

### Variables to adjust

| Variable | Default | Purpose |
|----------|---------|---------|
| `BOND_IF` | `bond0` | Bond interface name |
| `EXPECTED_PORTS` | `2` | Minimum healthy link count |
| `HA_WEBHOOK` | HA URL | Destination webhook |

### Test manually on the node

```bash
/usr/local/bin/bond-monitor.sh
```

Or force a degraded alert by temporarily setting `EXPECTED_PORTS=999` in a test run:

```bash
EXPECTED_PORTS=999 /usr/local/bin/bond-monitor.sh
```
