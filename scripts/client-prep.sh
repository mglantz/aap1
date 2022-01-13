#!/bin/bash
# Client prep

# Create directory for ssh public key
if [ ! -d /root/.ssh ]; then
  mkdir /root/.ssh
  chmod 600 /root/.ssh
fi

useradd student
echo "RHforum20Pass" | passwd student --stdin
usermod -aG wheel student
# I know I shouldn't edit the /etc/sudoers file with any sort of script. There's a reason for the visudo command.
# That being said...
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
mkdir /home/student/.ssh
chmod 700 /home/student/.ssh

for THEDIR in /home/student/.ssh/authorized_keys /root/.ssh/authorized_keys; do
cat << 'EOF' >$THEDIR
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRVIRvlAwQ4pbwyISj9Rekpyi6hKSeYzGCmZG3Pq7/mg/cekHhgWRSqFOM13AsKzR6jiSFU73+ifQSM0g8oi3R95sFDY4QeGXastziQ3aHUio40YteE/lUADaRyBy7w2jmnu0+se3jK8wymq2MwaFbTtMeUBvMhOvuudhvG1cB/zcH0TLnadTW+Oqmu2CvNpUlpq1DIiI10XUphaHpETFfOYyIQ7STiiEd4ink3iPy8zGmzgQkeK41crz6ENeBnj8tgL4o2rMmYWlRgjj/t8e2sUDz3wEVxC2JhZDewuZ6ImJ2yNLt+8yOhc2kTu3oo4pZ2f/kdColqf/BMXOtfP5B
EOF
done

chmod 600 /home/student/.ssh/*
chown student:student /home/student/.ssh -R

mkdir /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/*
