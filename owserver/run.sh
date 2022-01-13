#!/usr/bin/with-contenv bashio

echo "Starting OneWire server..."
owserver -c /etc/owfs.conf --foreground 
echo "Done."
