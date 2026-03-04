# Overseerr / Jellyseerr Setup

**Settings > Notifications > Webhook**

| Field  | Value |
|--------|-------|
| Webhook URL | `http://192.168.7.170:8123/api/webhook/seerr_alert` |
| Enable | On |

Enable all notification types — the automation routes them:

| Event             | Action |
|-------------------|--------|
| MEDIA_AVAILABLE   | iOS push |
| MEDIA_DECLINED    | iOS push |
| MEDIA_FAILED      | iOS push |
| MEDIA_PENDING     | Persistent HA notification |
| MEDIA_APPROVED    | Persistent HA notification |
| TEST_NOTIFICATION | iOS push |

Click **Send Test Notification** to verify.
