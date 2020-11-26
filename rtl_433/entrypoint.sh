#!/usr/bin/env bashio


CONFIG_PATH=/data/options.json

# MQTT_HOST=$(jq --raw-output ".host" $CONFIG_PATH)
# MQTT_PORT=$(jq --raw-output ".port" $CONFIG_PATH)
# MQTT_USER=$(jq --raw-output ".user" $CONFIG_PATH)
# MQTT_PASS=$(jq --raw-output ".pass" $CONFIG_PATH)
# MQTT_HOST=$(bashio::services mqtt "host")
# MQTT_PORT=$(bashio::services mqtt "port")
# MQTT_USER=$(bashio::services mqtt "username")
# MQTT_PASS=$(bashio::services mqtt "password")
MQTT_HOST=$(bashio::config "host")
MQTT_PORT=$(bashio::config "port")
MQTT_USER=$(bashio::config "user")
MQTT_PASS=$(bashio::config "pass")

RTL_OPTIONS=$(bashio::config "rtl_options")

python3 /rtl_433_mqtt_hass.py \
	--host ${MQTT_HOST} --port ${MQTT_PORT} \
	--user ${MQTT_USER} --password ${MQTT_PASS} \
	--retain &

rtl_433 -F kv -F mqtt://${MQTT_HOST}:${MQTT_PORT},user=${MQTT_USER},pass=${MQTT_PASS} ${RTL_OPTIONS}
