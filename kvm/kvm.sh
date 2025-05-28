#!/bin/bash

#install
sudo apt install --ignore-missing qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager

#Set virtualization service to autostart, restart it, check it 
sudo systemctl enable libvirtd
sudo systemctl restart libvirtd
sudo systemctl status libvirtd 

#Final check that KVM is loaded. You should get something like "kvm_intel" or "kvm_amd"
sudo lsmod | grep -i kvm 

#add to KVM group
sudo usermod -aG libvirt <username>
sudo usermod -aG kvm <username>
# Adjust permissions
sudo chmod 660 /var/run/libvirt/libvirt-sock
sudo chown root:libvirt /var/run/libvirt/libvirt-sock

#Configure libvirt to Allow Group Access
sudo nano /etc/libvirt/libvirtd.conf
#Find and set the following parameters:
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"