# Tautulli & Plex Setup

Use **Tautulli** for rich Plex monitoring (recommended).
Use **direct Plex webhooks** as a complement or if Tautulli is unavailable.

---

## Tautulli (Recommended)

**Settings > Notification Agents > Add > Webhook**

| Field  | Value |
|--------|-------|
| Webhook URL | `http://192.168.7.170:8123/api/webhook/tautulli_alert` |
| HTTP Method | POST |

### JSON Data (Triggers tab — set for each trigger)

Paste this as the JSON data body for each enabled trigger:

```json
{
  "action": "{action}",
  "user": "{user}",
  "title": "{title}",
  "media_type": "{media_type}",
  "grandparent_title": "{grandparent_title}",
  "parent_title": "{parent_title}",
  "player": "{player}"
}
```

### Recommended Triggers

| Trigger          | Notes |
|------------------|-------|
| Playback Start   | Generates persistent HA notification |
| Playback Stop    | Generates persistent HA notification |
| Watched          | Generates persistent HA notification |

Disable Playback Pause/Resume to reduce noise.

---

## Direct Plex Webhooks (Plex Pass)

**Plex > Settings > Webhooks > Add Webhook**

URL: `http://192.168.7.170:8123/api/webhook/plex_alert`

Plex sends `multipart/form-data` with a `payload` JSON field.
The HA automation handles this automatically.

### Events Handled

| Event             | Action |
|-------------------|--------|
| media.play        | Persistent HA notification |
| media.stop        | Persistent HA notification |
| media.scrobble    | Persistent HA notification (watched) |
| media.pause       | Ignored (too noisy) |
| media.resume      | Ignored (too noisy) |
