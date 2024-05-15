#!/bin/bash

# Generate and set password for support user
PASSWORD=$(date +%s | sha256sum | base64 | head -c 8)
if id "support" &>/dev/null; then
    echo "User 'support' already exists."
else
    useradd -rm -d /home/support -s /bin/bash -g root -G sudo -u 1000 support
    echo "support:$PASSWORD" | chpasswd
    echo "########################################"
    echo "User created: support"
    echo "Password: $PASSWORD"
    echo "This account is created for technical support and SSH access."
    echo "########################################"
fi

# Paths to move to /data
paths="/opt/z-way-server/automation/storage /opt/z-way-server/automation/userModules /opt/z-way-server/htdocs/smarthome/user/skin /opt/z-way-server/htdocs/smarthome/user/icons /etc/zbw"

for path in $paths; do
    if [ ! -e /data/$path ]; then
        mkdir -p /data/$(dirname $path)
        if [ -e $path ]; then
            mv $path /data/$path
            echo "Moved ${path} to /data${path}."
        else
            mkdir -p /data/$path
            echo "Created ${path} in /data."
        fi
    fi
    ln -sf /data$path $path
    echo "Created symlink for ${path}."
done

# Special case for config directory
if [ ! -e /data/opt/z-way-server/configs/config ]; then
    mkdir -p /data/opt/z-way-server/configs
    mv /opt/z-way-server/config /data/opt/z-way-server/configs/
    echo "Moved and symlinked config directory."
fi
ln -sf /data/opt/z-way-server/configs/ /opt/z-way-server/

# Start services
/etc/init.d/z-way-server start
/etc/init.d/zbw_connect start

# Tail the log file
tail -f /var/log/z-way-server.log | /opt/z-way-server/colorize-log.sh -q
