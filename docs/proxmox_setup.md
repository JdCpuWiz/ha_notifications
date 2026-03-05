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
