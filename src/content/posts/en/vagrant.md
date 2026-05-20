---
title: Getting Started with Vagrant
description: Learn how to set up your first Vagrant environment, manage virtual machines, and configure complex multi-node labs for development using VirtualBox, QEMU, or libvirt.
pubDate: 2025-07-30
categories: [DevOps]
tags: [vagrant, virtualization, automation]
draft: false
---

## First setup your vagrant file

To begin, you'll need to configure your Vagrantfile. You can refer to the official [vagrant documentation](https://developer.hashicorp.com/vagrant/docs/boxes)

First, install Vagrant and VirtualBox using the following commands:

```sh
sudo apt install vagrant
sudo apt install virtualbox
```

Vagrant is a powerful tool that allows you to manage and run virtual machines (VMs) using your preferred virtualization software. While **VirtualBox** is the most common provider, Vagrant also works seamlessly with other tools like **QEMU**, **virt-manager** (via the libvirt provider), or even Docker and VMware. This provides a consistent and efficient way to work with VMs, regardless of the underlying virtualization technology.

```alert
type: info
style: soft
You can setup a small LAB to make some tests very easily with vagrant.
```

### How to use vagrant

You need to create a VagrantFile. Here is a simple example:

```ruby title="VagrantFile"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_version = "20191107.0.0"
end
```

### Example complex config

You can also define multiple machines in a single file to create complex environments:

```ruby
Vagrant.configure("2") do |config|
  (1..2).each do |i|
    config.vm.define "master#{i}" do |master|
      master.vm.box = "almalinux/9"
      master.vm.network "private_network", ip: "192.168.10.1#{i}"
      # master.ssh.host = "192.168.10.1#{i}"
      master.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
      master.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
      end
    end
  end
end
```

```alert
type: warning
An image can be built for ARM or x86 architecture. Make sure to use the version that matches your hardware.
```
