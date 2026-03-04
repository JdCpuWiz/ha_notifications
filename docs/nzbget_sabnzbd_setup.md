# NZBGet & SABnzbd Setup

Neither app supports direct webhooks — both use post-processing scripts instead.

---

## NZBGet

### 1. Copy the script

```bash
cp scripts/nzbget_notify.sh /path/to/nzbget/scripts/
chmod +x /path/to/nzbget/scripts/nzbget_notify.sh
```

### 2. Enable in NZBGet

**Settings > Extension Scripts**

- Add `nzbget_notify.sh` to the scripts list
- Set the script type to `Post-Process`

### 3. Verify

Trigger a test download and check the HA dashboard for a persistent notification.

### Events

| Status   | Action |
|----------|--------|
| SUCCESS  | Persistent HA notification |
| FAILURE  | iOS push |
| WARNING  | Persistent HA notification |

---

## SABnzbd

### 1. Copy the script

```bash
cp scripts/sabnzbd_notify.sh /opt/scripts/
chmod +x /opt/scripts/sabnzbd_notify.sh
```

### 2. Configure in SABnzbd

**Config > Notifications > Script**

- Set the script path to `/opt/scripts/sabnzbd_notify.sh`
- Enable notification for: Download completed, Download failed

### Events

| Status     | Action |
|------------|--------|
| completed  | Persistent HA notification |
| failed     | iOS push |
