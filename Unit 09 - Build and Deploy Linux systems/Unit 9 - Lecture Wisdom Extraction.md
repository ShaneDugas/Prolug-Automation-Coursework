# Unit 9 - Build and Deploy Linux Systems: Lecture Wisdom Extraction

## Executive Summary

Unit 9 focuses on **building and deploying Linux systems at scale** using modern infrastructure automation tools. The unit covers Warewulf (a bare-metal provisioning framework), Apptainer (lightweight containers for HPC/Linux), and Ansible for system configuration management. These tools enable organizations to build, deploy, and manage large fleets of Linux systems from containerized images with consistent, reproducible results.

---

## Core Learning Objectives

1. Understand bare-metal provisioning with Warewulf
2. Use Apptainer for lightweight Linux system containers
3. Implement Ansible for configuration management
4. Build reproducible Linux system images
5. Deploy systems at scale with consistent configuration

---

## Key Concepts & Definitions

### Warewulf: Bare-Metal Linux Provisioning

**What it is**: A modern provisioning and lifecycle management framework for HPC and enterprise Linux systems

**Core Capabilities**:
- Boot bare metal servers over the network (PXE)
- Deliver operating system images to nodes
- Manage system lifecycle from bare metal to running
- Originally designed for HPC clusters
- Works with containerized OS images

**Key Components**:
1. **Image Library**: Repository of OS images
2. **Provisioning Server**: Provides boot and OS images
3. **Overlay System**: Customizations on top of base image
4. **Boot Process**: Network boot delivers OS to nodes

### Apptainer: Container Format for System Images

**What it is**: Lightweight container format optimized for scientific computing and system deployment

**Why Apptainer for System Deployment?**
- Single-file container format (easy to distribute)
- Lightweight (smaller than Docker)
- User-friendly (no daemon required)
- Good for HPC and system deployment
- Immutable (more secure)
- Easy to version/track

**Apptainer in Warewulf Context**:
- Warewulf pulls OS images from container registries
- Supports Docker images (converts automatically)
- Extracts container filesystem as root OS image
- Applies overlays for customization

### Ansible: Infrastructure Configuration Management

**What it is**: Agentless infrastructure automation and configuration management tool

**Core Concept**: Describe desired state in YAML, Ansible makes it happen

**Key Strengths**:
- Agentless (no software installation required)
- Simple, readable syntax (YAML)
- Push-based (control from single location)
- Flexible (works with anything)
- Good for: Configuration, deployment, updates

**Use in System Deployment**:
```yaml
Tasks:
1. Install packages (package manager)
2. Configure services (templates, files)
3. Start/enable services
4. Run custom scripts
5. Verify system state
```

---

## Complete System Build & Deploy Workflow

### Stage 1: Environment Setup

**Goal**: Install required tools and prepare workstation

**Steps**:
```bash
1. Update system packages
   apt -y update && apt -y install make git

2. Install/upgrade Go (Warewulf dependency)
   Remove old version: apt purge golang-go
   Download new: wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
   Extract to /usr/local: tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
   Add to PATH: export PATH=$PATH:/usr/local/go/bin

3. Install Ansible
   apt -y install ansible

4. Install Apptainer (container support)
   add-apt-repository -y ppa:apptainer/ppa
   apt update && apt install -y apptainer apptainer-suid
```

**Why these tools?**
- Go: Warewulf is written in Go
- Ansible: Configure nodes post-deployment
- Apptainer: Provide OS images as containers
- Make/Git: Build system and version control

### Stage 2: Warewulf Installation

**Goal**: Install and configure the provisioning framework

**Steps**:
```bash
1. Clone Warewulf repository
   git clone https://github.com/warewulf/warewulf.git

2. Build from source
   cd warewulf
   make

3. Install
   make install
   # Compiles and installs to /usr/local/bin and /etc/warewulf

4. Set up configuration
   cp /usr/local/etc/warewulf/warewulf.conf.example /etc/warewulf/warewulf.conf
   # Edit warewulf.conf for your network/environment
```

**Key Configuration**:
- DHCP/TFTP server settings (for PXE boot)
- Network interface to provision on
- Image storage location
- Node group settings

### Stage 3: OS Image Preparation

**Goal**: Get a Linux OS ready for deployment

**Steps**:
```bash
1. Import container image from registry
   wwctl image import --build docker://ghcr.io/warewulf/warewulf-rockylinux:9 my-rocky-image

   This:
   - Downloads container from registry
   - Extracts filesystem
   - Stores as Warewulf image
   - Makes it available for provisioning

2. List available images
   wwctl image list
   # Shows all prepared images

3. Inspect image (run commands inside)
   wwctl image shell my-rocky-image
   # Drops into interactive shell in the image

4. Inside the image, check system info
   uname -r              # Check kernel version
   cat /etc/*release     # Check OS release
```

**What's Inside a Warewulf Image?**
- Base OS filesystem (Rocky Linux, Ubuntu, etc.)
- System packages and utilities
- No running services (just filesystem)
- Ready to customize before deployment

### Stage 4: Image Discovery

**Goal**: Find where Warewulf stores images

**Steps**:
```bash
1. Search for warewulf directory
   find / -name warewulf

   Typical location: /var/local/warewulf/

2. Navigate to image root
   cd /var/local/warewulf/chroots/my-rocky-image/

   This contains:
   ├── rootfs/          # The actual filesystem
   │   ├── bin/
   │   ├── etc/
   │   ├── usr/
   │   ├── var/
   │   └── ...
   └── overlays/        # Custom modifications
```

**Why This Matters**:
- You can manually inspect images
- Direct filesystem access for troubleshooting
- Foundation for customization

---

## System Customization Methods

### Method 1: Manual Customization

**Process**:
```bash
1. Drop into image shell
   wwctl image shell my-rocky-image

2. Make changes
   # Install packages
   dnf install telnet

   # Edit configuration files
   vi /etc/someconfig

   # Run scripts
   bash /tmp/setup.sh

3. Exit the shell
   exit

4. Changes persist in image
   # Now all deployed nodes get these changes
```

**When to Use**:
- One-off fixes
- Debugging image issues
- Quick customization
- Testing before automation

**Limitations**:
- Not repeatable
- Hard to track changes
- Manual work scales poorly

### Method 2: Ansible Automation

**Advantage**: Repeatable, version-controlled, scales to thousands of nodes

**Setup Process**:

```bash
1. Fix image network connectivity (for Ansible to run commands)
   cd /var/local/warewulf/chroots/my-rocky-image/etc/
   vi resolv.conf
   # Add: nameserver 8.8.8.8 (or your DNS)

2. Create Ansible workspace
   mkdir /root/ansible
   cd /root/ansible

3. Create inventory file (hosts.ini)
   # Define how to access the chroot
   vi /root/ansible/chroots

   [chroots]
   /var/local/warewulf/chroots/my-rocky-image/rootfs/ ansible_connection=chroot

   # This tells Ansible:
   # - Target: the filesystem at that path
   # - Connection type: chroot (run in chroot environment)
   # - No SSH needed (it's local)

4. Create Ansible playbook
   vi /root/ansible/package.yaml
```

**Playbook Example**:
```yaml
---
- name: Configure system packages
  hosts: chroots
  become: true

  tasks:
    - name: Install telnet
      package:
        name: telnet
        state: present

    - name: Install web server
      package:
        name: nginx
        state: present

    - name: Start nginx
      systemd:
        name: nginx
        enabled: yes
        state: started

    - name: Configure firewall
      firewalld:
        service: http
        state: enabled
        permanent: yes
        immediate: yes
```

**Run the Playbook**:
```bash
ansible-playbook -i /root/ansible/chroots /root/ansible/package.yaml
```

**What Happens**:
1. Ansible connects to chroot environment
2. Runs each task in sequence
3. Ensures desired state (installs if missing, skips if present)
4. Reports results
5. Image now contains all customizations

### Key Ansible Concepts

**Idempotence**: Tasks can run repeatedly without causing problems
```yaml
# Good: Package module is idempotent
- name: Install package
  package:
    name: telnet
    state: present
    # If already installed, does nothing
    # If not installed, installs
```

**Connection Types for Chroot**:
- `ansible_connection=chroot`: Local chroot (for image building)
- `ansible_connection=ssh`: Over SSH (for running systems)
- `ansible_connection=local`: Local shell (for localhost)

**Task Modules for System Configuration**:
- `package`: Install/remove packages
- `systemd`: Start/stop/enable services
- `copy`: Copy files
- `lineinfile`: Edit text files
- `shell`/`command`: Run scripts
- `file`: Create/delete files/directories

---

## Deployment Architecture

### Single Server Deployment Flow

```
Bare Metal Server
    ↓
PXE Boot (network boot)
    ↓
Warewulf Server provides:
  - Bootloader
  - Kernel
  ↓
Server boots kernel, receives root filesystem
    ↓
Root filesystem mounted
    ↓
Init system starts
    ↓
Ansible playbook runs (post-boot)
    ↓
System ready for use
```

### Multi-Node Deployment

```
Warewulf Master
├── Image: my-rocky-image
├── Node Group: HPC-Cluster
│   ├── node-001
│   ├── node-002
│   └── node-003
└── Ansible Inventory
    └── Runs on all nodes post-boot
```

**Power of This Approach**:
- Single image serves hundreds of nodes
- All nodes identical (configuration drifting prevented)
- Changes to image applied to new boots
- Ansible handles post-boot customization
- Nodes can be ephemeral (destroyed and recreated)

---

## Advanced Customization: Error Handling

### Example: Testing Exit Codes

```bash
1. Run command that fails
   false

2. Check exit code (in Ansible, outside image)
   echo $?
   # Output: 1 (failure)

3. In playbook, fail on bad exit
   - name: Run check
     command: false
     check on failure
```

**In Ansible**:
```yaml
- name: Verify system
  command: some-check
  register: result
  failed_when: result.rc != 0

- name: Fail if check failed
  fail:
    msg: "Check failed"
  when: result.failed
```

---

## Best Practices for System Deployment

### 1. Use Version Control for Everything
```
Git repository:
├── ansible/
│   ├── playbooks/
│   │   ├── base-system.yaml
│   │   ├── hpc-cluster.yaml
│   │   └── web-cluster.yaml
│   ├── inventory/
│   └── roles/
├── warewulf/
│   └── warewulf.conf
└── README.md (setup instructions)
```

### 2. Test Changes Incrementally
```
1. Manual testing in wwctl image shell
2. Convert to Ansible playbook
3. Test on single node first
4. Roll out to test environment
5. Promote to production
```

### 3. Immutable Infrastructure Approach
```
Change needed?
  → Create new image with changes
  → Deploy new image to nodes
  → Nodes reboot with new OS
  → Old image version available for rollback

Don't:
  → SSH into running system
  → Make manual changes
  → Hope changes stick across reboot
```

### 4. Maintain Base Image + Overlays
```
Base Image: Rocky Linux 9
  └── Overlays:
      ├── HPC packages (MPI, OpenFOAM)
      ├── Web server (nginx, PHP)
      └── Database (PostgreSQL)
```

### 5. Document Everything
```
For each image/configuration:
- What is it for?
- What's installed?
- What services are running?
- How to test/verify?
- How to update?
- Known issues/limitations?
```

---

## Critical Insights

1. **Immutability is Security**: Treat nodes as ephemeral, rebuild rather than patch
2. **Ansible is Agentless**: No software installation on targets needed
3. **Chroot for Building**: Test everything locally before deploying
4. **Infrastructure at Scale**: Warewulf enables managing thousands of nodes consistently
5. **Version Control Everything**: Config, scripts, images - all tracked in Git

---

## Reflection & Application

### Questions to Consider
1. How many systems does your team manage manually today?
2. What configuration changes are made regularly that could be automated?
3. How would immutable infrastructure change your deployment process?
4. What's the timeline to convert from manual to automated deployment?

### Hands-On Learning Path
1. Install Warewulf on a test system
2. Import an OS image
3. Create a basic Ansible playbook
4. Deploy playbook to image
5. Boot a node with the customized image
6. Verify all customizations applied
7. Document the process

---

## Unit 9 Lab Focus

Apply the concepts by:
- Installing Warewulf and dependencies
- Preparing and customizing OS images
- Creating Ansible playbooks for system configuration
- Deploying to single node, then multiple nodes
- Testing deployment and rollback procedures
- Troubleshooting deployment issues

---

**Created**: 2026-01-05
**Based on**: Unit 9 Lab Notes, ProLUG Automation Engineering Course
**Topics**: Warewulf, Bare-Metal Provisioning, Apptainer, Ansible, Linux System Deployment, Infrastructure as Code, Immutable Infrastructure
