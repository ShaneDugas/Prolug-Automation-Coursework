Unit 12 Discussion Post 1: You have a set of older routers that have been traditionally connected to and configured over ssh via the command line (CLI) in Cisco Internetwork Operating System (IOS). You decide to backup the current configs of all routers with ansible, how might you lay out the cisco.ios.ios_config module to backup up everything to a local folder on your jump server?
![[Pasted image 20260305230232.png]]

```
https://docs.ansible.com/projects/ansible/latest/collections/cisco/ios/ios_config_module.html

-To back up older Cisco IOS switch/router configurations with Ansible, I would place the routers in an inventory group and use the cisco.ios.ios_config module with "backup: true". 
-I would define backup_options.dir_path to point to a local directory on the jump server, such as /var/backups/ansible/cisco_ios, and set a unique filename using {{ inventory_hostname }}. 
-The routers would use the ansible.netcommon.network_cli connection type. This approach lets Ansible log into each router over SSH, pull the running configuration, and save it locally in a structured backup folder.

In the example, there are a few useful examples. For one, diff against intended could be useful for creating a "golden" configuration that you could use to check for configuration drift. Similarly, diff against startup can be used to check for changes that have been made but yet not saved.

```


Unit 12 Discussion Post 2: You’ve read that software defined networking (SDN) is the new hotness in the network engineering world. Your organization mostly uses VPC’s inside of AWS and you want to learn more about what SDN means in the cloud. Can you find some good SDN configuration blogs about the topic and prepare a couple paragraphs for a memo to your other engineers on the team?

```
Guys, 
I've been researching the software-defined networking stuff we talked about. SDN can be thought of as networking expressed through software-managed abstractions rather than box-by-box hardware configuration. In AWS, the main SDN building block is the Amazon VPC, which gives us a logically isolated network where we define subnets, IP ranges, route tables, gateways, and security groups. AWS documentation describes VPC as a virtual network that resembles a traditional data-center network, but with cloud-scale managed infrastructure underneath. For us, coming from a traditional networking background, the important shift is that the control points are no longer physical routers and switches; they are cloud-native policy objects and attachment models that determine reachability, segmentation, and service exposure.

In practice, SDN in AWS also changes how we operate the network. Instead of treating network changes as one-off CLI actions, AWS recommends a NetDevOps model built around automation, modular design, testing, and CI/CD pipelines. That is especially relevant as environments grow from a few VPCs to many accounts, regions, and hybrid connections. The engineering takeaway is that cloud SDN is not merely “virtual switches”; it is an API-driven network control plane where topology, routing, segmentation, and security are defined as code and applied consistently at scale.

This is a good explanation of what VPCs are.
https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
https://aws.amazon.com/blogs/startups/practical-vpc-design/
https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/

```