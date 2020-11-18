vidPid="0bda:2838"
devPath="/dev/bus/usb/$(lsusb -d $vidPid | sed 's/^.*Bus\s\([0-9]\+\)\sDevice\s\([0-9]\+\).*$/\1\/\2/g')"
#chown $USER $devPath
docker run --rm --device=$devPath --name rtl_433 rtl:latest

#docker run --rm --device=$devPath \
# -e RTL_OPTS="-F kv -F mqtt://192.168.10.4:1883,user=writer,pass=_writer,devices=rtl_433/[channel]/[id],states=rtl_433/[channel]/[id],events=rtl_433/[channel]/[id]" stephenhouser/rtl_433:latest


# BUILD_FROM=homeassistant/amd64-base docker build .