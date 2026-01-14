Lab buildout for Unit 9

Setup the version of go that works with Warewulf

1. apt -y update && apt -y install make git
2. rm -rf /usr/local/go
3. apt purge golang-go
4. wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
5. tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
6. export PATH=$PATH:/usr/local/go/bin

Install Ansible
1. apt -y install ansible

Build Warewulf on Ubuntu.

1. git clone https://github.com/warewulf/warewulf.git
2. cd warewulf 
3. make
4. make install       #this may take 8 minutes
5. cp /usr/local/etc/warewulf/warewulf.conf.example /etc/warewulf/warewulf.conf

Install apptainer

1. add-apt-repository -y ppa:apptainer/ppa
2. apt update && apt install -y apptainer apptainer-suid
3. apptainer --version

Download and prepare an image

1. wwctl image import --build docker://ghcr.io/warewulf/warewulf-rockylinux:9 my-rocky-image
2. wwctl image list
3. uname -r
4. cat /etc/*release
5. wwctl image shell my-rocky-image
6. uname -r 
7. cat /etc/*release
8. dnf update
  a. hit N, as we don't want to update now.
9. false
10. exit
  a. What error code do we see? Why is that?
  
Find where that image is, for automated chroot activities.
1. find / -name warewulf
2. cd /var/local/warewulf/chroots/my-rocky-image/


Get a version of an OS downloaded

Modify the OS inside Warewulf
  - manually
  - with Ansible


==============================

Modify the OS inside Warewulf
  - manually
    - wwctl image shell my-rocky-image
      - make modifications
      - exit
  - with Ansible
    Pre: fix your resolv.conf 
    cd /var/local/warewulf/chroots/my-rocky-image/etc/
    vi resolv.conf
    #add the line
    nameserver 8.8.8.8
  
    1. mkdir /root/ansible
    2. cd /root/ansible
    3. vi /root/ansible/chroots
       #add the following lines
       [chroots]
       /var/local/warewulf/chroots/my-rocky-image/rootfs/ ansible_connection=chroot
    4. vi /root/ansible/package.yaml
       #add the following lines
---
- name: Install cowsay on all hosts
  hosts: chroots
  become: true  # This allows the tasks to run with elevated privileges (s

     tasks:
      - name: Ensure cowsay package is installed
        package:
          name: telnet
          state: present