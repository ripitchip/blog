---
title: Débuter avec Vagrant
description: Apprenez à configurer votre premier environnement Vagrant, gérer des machines virtuelles et configurer des laboratoires multi-nœuds complexes pour le développement avec VirtualBox, QEMU ou libvirt.
pubDate: 2025-07-30
categories: [DevOps]
tags: [vagrant, virtualization, automation]
draft: false
---

## Configurez votre premier fichier Vagrant

Pour commencer, vous devrez configurer votre Vagrantfile. Vous pouvez vous référer à la [documentation officielle de Vagrant](https://developer.hashicorp.com/vagrant/docs/boxes).

Tout d'abord, installez Vagrant et VirtualBox en utilisant les commandes suivantes :

```sh
sudo apt install vagrant
sudo apt install virtualbox
```

Vagrant est un outil puissant qui vous permet de gérer et d'exécuter des machines virtuelles (VM) en utilisant votre logiciel de virtualisation préféré. Bien que **VirtualBox** soit le fournisseur le plus courant, Vagrant fonctionne également de manière transparente avec d'autres outils comme **QEMU**, **virt-manager** (via le fournisseur libvirt), ou même Docker et VMware. Cela offre un moyen cohérent et efficace de travailler avec des VM, quelle que soit la technologie de virtualisation sous-jacente.

```alert
type: info
style: soft
Vous pouvez configurer un petit laboratoire (LAB) pour effectuer des tests très facilement avec Vagrant.
```

### Comment utiliser Vagrant

Vous devez créer un Vagrantfile. Voici un exemple simple :

```ruby title="VagrantFile"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_version = "20191107.0.0"
end
```

### Exemple de configuration complexe

Vous pouvez également définir plusieurs machines dans un seul fichier pour créer des environnements complexes :

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
Une image peut être construite pour l'architecture ARM ou x86. Assurez-vous d'utiliser la version qui correspond à votre matériel.
```
