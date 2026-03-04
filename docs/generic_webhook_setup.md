# Generic Webhook Setup

The `generic_alert` webhook is a catch-all for any app or script that can POST JSON.
Use it for: Patchmon, custom cron jobs, monitoring scripts, or any app not listed elsewhere.

## Endpoint

```
POST http://192.168.7.170:8123/api/webhook/generic_alert
Content-Type: application/json
```

## Payload Format

```json
{
  "title": "Alert title",
  "message": "Detailed description of what happened",
  "severity": "critical",
  "source": "app-name"
}
```

### Severity Levels

| Level    | Action |
|----------|--------|
| `critical` | iOS push (bypasses DND) + persistent HA notification |
| `warning`  | iOS push only |
| `info`     | Persistent HA notification only (no push) |

Defaults to `info` if `severity` is missing.

## Patchmon Configuration

Configure Patchmon to POST to `generic_alert` with:
- `severity: "warning"` for available updates
- `severity: "critical"` for security patches
- `source: "patchmon"`

## Speedtest Tracker Configuration

**Settings > Notifications > Webhook**

URL: `http://192.168.7.170:8123/api/webhook/speedtest_alert`

The speedtest automation only fires when results fall below threshold (default: 100 Mbps down / 20 Mbps up).
Edit `automations/speedtest_webhook.yaml` to adjust thresholds for your ISP plan.

## Dispatcharr Configuration

**Settings > Notifications > Webhook**

URL: `http://192.168.7.170:8123/api/webhook/dispatcharr_alert`

## Quick Test

```bash
curl -X POST http://192.168.7.170:8123/api/webhook/generic_alert -H "Content-Type: application/json" -d '{"title":"Test","message":"Hello from my script","severity":"warning","source":"cron"}'
```
