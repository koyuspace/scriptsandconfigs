#!/bin/bash
sudo systemctl stop mastodon-* --all
sudo systemctl stop matrix-synapse
sudo -u postgres pg_dumpall > /root/db.out
export RESTIC_PASSWORD=hellno
restic -o rclone.args="serve restic --stdio --verbose" -r rclone:onedrive:koyuspace_backups backup /home/mastodon /etc/caddy /var/lib/redis /root/db.out /home/koyu /var/www /var/lib/matrix-synapse/ /etc/matrix-synapse/
sudo systemctl start mastodon-* --all
sudo systemctl start matrix-synapse
