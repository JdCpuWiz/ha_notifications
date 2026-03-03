# CLAUDE.md

Home Assistant notification integration project.
Replaces the pushlab Go backend by routing alerts through an existing HA instance.

## Goal

Use Home Assistant webhook automations to receive alerts from tools like Dockmon
and forward them as push notifications to iOS via the HA Companion app.

## Structure

```
automations/    HA automation YAML files (import via HA UI or automations.yaml)
scripts/        Helper/test scripts (curl one-liners, etc.)
docs/           Setup guides
```

## HA Instance

- URL: http://192.168.7.170:8123
- Notify service: notify.mobile_app_skank

## Testing

Send a test webhook:
curl -X POST http://192.168.7.170:8123/api/webhook/YOUR_WEBHOOK_ID -H "Content-Type: application/json" -d '{"title":"Test","message":"Hello from curl"}'
