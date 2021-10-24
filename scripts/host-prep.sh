#!/bin/bash
# Prepare host for installation

# Update system to latest
dnf update -y

# Enable RHSM management
sed -i -e 's/manage_repos = 0/manage_repos = 1/g' /etc/rhsm/rhsm.conf

# Disable Amazon RHUI. Re-enable by moving repo files.
mkdir /root/backup
mv /etc/yum.repos.d/* /root/backup/

# Register to RHN
subscription-manager register --username=THEUSER --password="THEPASSWORD" --auto-attach --force

# Enable AAP pool id
subscription-manager attach --pool=THEPOOL

# Reboot to latest versions
reboot
