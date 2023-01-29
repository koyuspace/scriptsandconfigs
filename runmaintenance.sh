#!/bin/bash
sudo systemctl stop mastodon-* --all
sudo -u postgres pg_dumpall > /root/db.out
export RESTIC_PASSWORD=hellno
restic -o rclone.args="serve restic --stdio --verbose" -r rclone:onedrive:koyuspace_backups backup /home/mastodon /etc/nginx /var/lib/redis /root/db.out /home/koyu
sudo systemctl start mastodon-* --all
