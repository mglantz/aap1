#!/bin/bash
# Prepare host for installation

# Enable RHSM management
sed -i -e 's/manage_repos = 0/manage_repos = 1/g' /etc/rhsm/rhsm.conf

# Disable Amazon RHUI. Re-enable by moving repo files.
mkdir /root/backup
mv /etc/yum.repos.d/* /root/backup/

# Register to RHN
subscription-manager register --username=THEUSER --password="THEPASSWORD" --auto-attach --force

# Enable AAP pool id
subscription-manager attach --pool=THEPOOL

# Enable Ansible 2.9
subscription-manager repos --enable=ansible-2.9-for-rhel-8-x86_64-rpms

# Update system to latest versions and reboot if successful
dnf clean all
dnf update -y && reboot
