#!/bin/sh

systemctl disable systemd-resolved.service
systemctl stop systemd-resolved.service
docker start bb761292413c
systemctl enable systemd-resolved.service
systemctl stop systemd-resolved.service
