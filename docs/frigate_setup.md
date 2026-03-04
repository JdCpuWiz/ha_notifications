# Frigate Setup

Frigate publishes events to MQTT. The HA automation subscribes to the `frigate/events` topic.

## Prerequisites

1. **MQTT Broker** running (e.g. Mosquitto add-on in HA)
2. **MQTT Integration** installed in HA (Settings > Devices & Services > Add Integration > MQTT)
3. **Frigate** configured to connect to the same MQTT broker

## Frigate config.yaml (MQTT section)

```yaml
mqtt:
  host: 192.168.7.170   # HA/Mosquitto broker IP
  port: 1883
  topic_prefix: frigate
  client_id: frigate
  # user: mqtt_user       # if auth required
  # password: mqtt_pass
```

## Automation Behaviour

- Only fires on `new` events (not updates or end)
- Skips false positives automatically
- Sends iOS push with `time-sensitive` interruption level (shows through Focus)
- Message format: `Person detected on Front Door (94% confidence)`

## Filtering by Camera or Label (optional)

To only notify for specific cameras or labels, add conditions to the automation:

```yaml
  - condition: template
    value_template: "{{ label in ['person', 'car'] }}"
  - condition: template
    value_template: "{{ camera in ['front_door', 'driveway'] }}"
```

Add these after the existing false-positive condition.
