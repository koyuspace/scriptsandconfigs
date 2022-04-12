#!/bin/bash
systemctl stop mastodon-* --all
su - postgres -c pg_dumpall > /home/koyu/koyuspace.db
systemctl start mastodon-* --all
export RESTIC_PASSWORD=hellno
restic -o rclone.args="serve restic --stdio --verbose" -r rclone:onedrive:koyuspace_backups backup /home/mastodon /etc/nginx /var/lib/redis /home/gemini/ /home/koyu/ /usr/bin/runmaintenance /var/lib/tor/ /etc/tor /etc/letsencrypt --verbose
rm /home/koyu/koyuspace.db
sudo -i -u mastodon bash << EOF
cd /home/mastodon/live/
tootctl media remove --concurrency 50
EOF
