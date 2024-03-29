# Laboratorio Ansible

Proyecto de Ansible (experimental y de aprendizaje) para automatizar la preparación de mi notebook personal. La idea (o intención) es que funcione en Ubuntu, Linux Mint y PopOS [al fin y al cabo son lo mismo (?)].

## Equipo

```test
OS: Pop!_OS 22.04 LTS
Kernel: x86_64 Linux 5.15.0-58-generic
Disk: 256G
CPU: 11th Gen Intel Core i5-1135G7 @ 8x 4,2GHz
GPU: Mesa Intel(R) Xe Graphics (TGL GT2)
RAM: 15653MiB
```

## Preparación

```bash
# Probando deploy con script
$ sudo apt install curl
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/diegobollini/my_ansible/master/deploy.sh)"
$ sudo bash launch_project.sh
```

### Deploy manual

```bash
# Dependencias
$ apt install python3-setuptools ansible git stow
# Clonar repositorio con playbooks, tasks, etc.
$ git clone https://github.com/diegobollini/my_ansible && cd my_ansible
# Deployar rol
$ ansible-playbook playbooks/notebook.yml -K --verbose
# También pueden usarse tags para tareas específicas
$ ansible-playbook playbooks/notebook.yml --tags=github-cli,packages_dev -K --verbose
```

## Post instalación

Algunos comandos y tareas artesanales pendientes de automatizar:

```bash
# git config
$ git config --global user.name "diegobollini"
$ git config --global user.email diegobollini@protonmail.com
# Configurar ssh en github
$ gh auth login
$ gh ssh-key add /home/diego/.ssh/private_key_diego.pub
# Validar: https://github.com/diegobollini.keys
```

## Tareas y tags

- packages
  - packages_system
  - packages_compression
  - packages_other
  - packages_hardware
  - packages_performance
  - packages_dev
- browsers
  - chrome
  - firefox (ubuntu)
- language
  - language
- social
  - telegram
  - discord
- appearence
  - appearence_wallpaper
  - appearence_gnome
- ssh
  - ssh (key y config)
- code
  - code
- python
  - python3 (dependencias)
- docker
  - docker
- git
  - github_cli
  - git_config
- meld
  - meld
- zsh
  - zsh
  - omz (y plugins varios)
- security
  - ufw
- network
  - dns
- tweaks
  - extensions
  - dock

## Testeando con [vagrant](vagrantup.com)

- [Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search)
- Levantar, ejecutar, acceder, etc.:

```sh
$ vagrant init generic/ubuntu2204
$ vagrant up
$ vagrant ssh
$ logout
$ vagrant box list
generic/ubuntu2204 (virtualbox, 4.1.10)
#
$ vagrant snapshot save [vm-name] NAME
$ vagrant snapshot save default ubuntu2204
==> default: Snapshotting the machine as 'ubuntu2204'...
$ vagrant snapshot restore [vm-name] NAME
$ vagrant snapshot restore default vm_2204
#
$ vagrant snapshot list
==> default:
ubuntu2204
$ vagrant global-status
id       name    provider   state  directory
-----------------------------------------------------------------------
b3fafcb  default virtualbox saved  /.../ansible
#
$ vagrant snapshot push
$ vagrant snapshot pop
#
$ vagrant destroy
$ vagrant box list
$ vagrant box remove hashicorp/bionic64
```
