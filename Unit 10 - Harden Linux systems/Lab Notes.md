---
Current: 2026-01-10 10:27am
Created: 2026-01-10 10:27am
tags:
---
# Lab Notes

chmod 0750 /usr/local/share/warewulf/overlays/host/rootfs
install -m 0755 wwctl /usr/local/bin
install -m 0644 include/firewalld/warewulf.xml /usr/lib/firewalld/services
install -m 0644 include/systemd/warewulfd.service /usr/lib/systemd/system
install -m 0644 LICENSE.md /usr/local/share/doc/warewulf
install -m 0644 etc/bash_completion.d/wwctl /etc/bash_completion.d/wwctl
for f in docs/man/man1/*.1.gz; do install -m 0644 $f /usr/local/share/man/man1/; done
for f in docs/man/man5/*.5.gz; do install -m 0644 $f /usr/local/share/man/man5/; done
install -pd -m 0755 /usr/lib/dracut/modules.d/90wwinit
install -m 0644 dracut/modules.d/90wwinit/*.sh  dracut/modules.d/90wwinit/*.override /usr/lib/dracut/modules.d/90wwinit
# copy ifupdown to debian.interfaces for backwards compatibility with previous name
cp -a /usr/local/share/warewulf/overlays/ifupdown /usr/local/share/warewulf/overlays/debian.interfaces
install -d -m 0755 /usr/local/share/warewulf/overlays/wwclient/rootfs//warewulf
cp -a /usr/local/share/warewulf/overlays/wwclient /usr/local/share/warewulf/overlays/wwclient.aarch64
cp -a /usr/local/share/warewulf/overlays/wwclient /usr/local/share/warewulf/overlays/wwclient.x86_64
install -m 0755 wwclient /usr/local/share/warewulf/overlays/wwclient/rootfs//warewulf/wwclient
install -m 0755 wwclient.x86_64 /usr/local/share/warewulf/overlays/wwclient.x86_64/rootfs//warewulf/wwclient
install -m 0755 wwclient.aarch64 /usr/local/share/warewulf/overlays/wwclient.aarch64/rootfs//warewulf/wwclient

real    8m33.003s
user    5m19.163s
sys     0m42.026s

---

controlplane:~/warewulf$ time wwctl image import --build docker://ghcr.io/warewulf/warewulf-rockylinux:9 my-rocky-image
Copying blob ad10292ae675 done   | 
Copying blob 812c44127102 done   | 
Copying blob f756824cac1e done   | 
Copying blob 4f4fb700ef54 done   | 
Copying blob d7736957bfef done   | 
Copying blob d819ba3bb816 done   | 
Copying blob db15c9242c45 done   | 
Copying config 6504e82a34 done   | 
Writing manifest to image destination
2026/01/10 16:27:36  info unpack layer: sha256:812c44127102f257d376d2c571aa5be68fbe4e46316a772cfeb9ac359f1adf09
2026/01/10 16:27:43  info unpack layer: sha256:f756824cac1e7b81a05985f86b71bb30433631f614663130ac293ed4ac58ad75
2026/01/10 16:28:12  info unpack layer: sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1
2026/01/10 16:28:12  info unpack layer: sha256:d7736957bfefd1910653ebe1a0df809802bc2f950390a0f45445ee8ba7bfe897
2026/01/10 16:28:12  info unpack layer: sha256:d819ba3bb816e844f9c54f0ac2bbfa42883b361404b2dd71221a202ab6451d42
2026/01/10 16:28:12  info unpack layer: sha256:ad10292ae67532cdf4347bb518e7a4312ecadd574be4d5095fb2c6c60f780136
2026/01/10 16:28:12  info unpack layer: sha256:db15c9242c4512b762225719bd3226a7fff24d634f32b8734c7546f9cba2dc7c
Building image: my-rocky-image
Building image: my-rocky-image
Created image for Image my-rocky-image: /var/local/warewulf/provision/images/my-rocky-image.img
Compressed image for Image my-rocky-image: /var/local/warewulf/provision/images/my-rocky-image.img.gz

real    3m6.731s
user    1m16.200s
sys     0m23.434s
controlplane:~/warewulf$ 

---
This is the base OS

controlplane:~/warewulf$ wwctl image list
IMAGE NAME
----------
my-rocky-image
controlplane:~/warewulf$ uname -r
6.8.0-90-generic
controlplane:~/warewulf$ cat /etc/*release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=24.04
DISTRIB_CODENAME=noble
DISTRIB_DESCRIPTION="Ubuntu 24.04.3 LTS"
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
controlplane:~/warewulf$ 

---
Now we are in the NEW image

[warewulf:my-rocky-image] /# uname -r
6.8.0-90-generic
[warewulf:my-rocky-image] /# cat /etc/*release
NAME="Rocky Linux"
VERSION="9.7 (Blue Onyx)"
ID="rocky"
ID_LIKE="rhel centos fedora"
VERSION_ID="9.7"
PLATFORM_ID="platform:el9"
PRETTY_NAME="Rocky Linux 9.7 (Blue Onyx)"
ANSI_COLOR="0;32"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:rocky:rocky:9::baseos"
HOME_URL="https://rockylinux.org/"
VENDOR_NAME="RESF"
VENDOR_URL="https://resf.org/"
BUG_REPORT_URL="https://bugs.rockylinux.org/"
SUPPORT_END="2032-05-31"
ROCKY_SUPPORT_PRODUCT="Rocky-Linux-9"
ROCKY_SUPPORT_PRODUCT_VERSION="9.7"
REDHAT_SUPPORT_PRODUCT="Rocky Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="9.7"
Rocky Linux release 9.7 (Blue Onyx)
Rocky Linux release 9.7 (Blue Onyx)
Rocky Linux release 9.7 (Blue Onyx)
[warewulf:my-rocky-image] /# 

---


controlplane:~/warewulf$ 
controlplane:~/warewulf$ cd /var/local/warewulf/chroots/my-rocky-image/
controlplane:/var/local/warewulf/chroots/my-rocky-image$ ls
rootfs
controlplane:/var/local/warewulf/chroots/my-rocky-image$ 


---
Run playbook against chroot - which is at /var/local/warewulf/chroots/my-rocky-image/rootfs

controlplane:~/stig/ansible$ ansible-playbook -i /root/ansible/chroots site.yml
[WARNING]: While constructing a mapping from /root/stig/ansible/roles/rhel9STIG/defaults/main.yml, line 2, column 1, found a duplicate dict key (rhel9STIG_stigrule_258027_Manage). Using
last defined value only.
/root/stig/ansible/roles/rhel9STIG/callback_plugins/stig_xml.py:51: SyntaxWarning: invalid escape sequence '\d'
  r = 'SV-{}r(?P<rev>\d+)_rule'.format(nid)
/root/stig/ansible/roles/rhel9STIG/callback_plugins/stig_xml.py:61: SyntaxWarning: invalid escape sequence '\d'
  m = re.search('stigrule_(?P<id>\d+)', name)
Using STIG_PATH: /root/stig/ansible/roles/rhel9STIG/files/U_RHEL_9_STIG_V2R4_Manual-xccdf.xml
Using XML_PATH: /tmp/tmp9m5c8g0b/xccdf-results.xml
Writing: /tmp/tmp9m5c8g0b/xccdf-results.xml

PLAY [chroots] ****************************************************************************************************************************************************************************

TASK [rhel9STIG : populate package facts] *************************************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257779__etc_issue] *********************************************************************************************************************************************
changed: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if systemd-journald.service is installed] *************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257783_systemd_journald_enable] ********************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if systemd-journald.service is installed] *************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257783_systemd_journald_start] *********************************************************************************************************************************
[WARNING]: Target is a chroot or systemd is offline. This can lead to false positives or prevent the init system tools from working.
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257784__etc_systemd_system_conf] *******************************************************************************************************************************
changed: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if ctrl-alt-del.target is installed] ******************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257785_ctrl_alt_del_target_disable] ****************************************************************************************************************************
changed: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if ctrl-alt-del.target is installed] ******************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257785_ctrl_alt_del_target_mask] *******************************************************************************************************************************
changed: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if debug-shell.service is installed] ******************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257786_debug_shell_service_disable] ****************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : check if debug-shell.service is installed] ******************************************************************************************************************************
ok: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257786_debug_shell_service_mask] *******************************************************************************************************************************
changed: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]

TASK [rhel9STIG : stigrule_257790__boot_grub2_grub_cfg_group_owner] ***********************************************************************************************************************
fatal: [/var/local/warewulf/chroots/my-rocky-image/rootfs/]: FAILED! => {"changed": false, "msg": "file (/boot/grub2/grub.cfg) is absent, cannot continue", "path": "/boot/grub2/grub.cfg", "state": "absent"}

PLAY RECAP ********************************************************************************************************************************************************************************
/var/local/warewulf/chroots/my-rocky-image/rootfs/ : ok=15   changed=5    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

controlplane:~/stig/ansible$ 

---

What does run, and what breaks? Why do you think this STIG Ansible playbook breaks? What does the error message tell you?

``` bash
It looks like it's breaking at the grub stig.  I'll have to investigate STIGRULE 257790 for details.
```


This is where the iterative process of image build starts to take shape. We need to approximately do these steps (outside of the scope of this lab)

Harden the image, as above
Deploy the system to a live node
Run your regression and function checks to ensure your base functionality still exists. 3a. If 3 passes, then run your STIG reports and see if you're at the minimum standard.
Repeat until functionality and minimum baseline are achieved.

