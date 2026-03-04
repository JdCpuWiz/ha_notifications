# Arr Stack Setup

Sonarr, Radarr, Lidarr, Readarr, and Prowlarr all share the same webhook endpoint.
The `instanceName` field in their payload is used to identify the source.

## Configure Each App

**Settings > Connect > Add > Webhook**

| Field        | Value |
|--------------|-------|
| Name         | `HomeAssistant` |
| Notification Triggers | See below |
| URL          | `http://192.168.7.170:8123/api/webhook/arr_alert` |
| Method       | POST |

## Recommended Triggers

| Trigger             | Push? | Notes |
|---------------------|-------|-------|
| On Health Issue     | Yes   | Important — indexer/disk problems |
| On Health Restored  | Yes   | Good to know when fixed |
| On Download         | No    | Persistent notification only |
| On Upgrade          | No    | Persistent notification only |
| On Grab             | No    | Persistent notification only |
| On Application Update | Yes | Notify when arr app updates |
| On Test             | Yes   | Use to verify connection |

Disable "On Rename" and "On Import Complete" to reduce noise.

## Instance Name

Set the instance name in each app so notifications are labelled correctly:

**Settings > General > Instance Name**

Suggested names: `Sonarr`, `Radarr`, `Lidarr`, `Readarr`, `Prowlarr`
