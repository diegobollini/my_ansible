# Laboratorio Ansible

Proyecto de Ansible (experimental y de aprendizaje) para automatizar la preparación de mi notebook personal. La idea (o intención) es adaptarlo a las distintas distros que voy usando (Ubuntu, Linux Mint, Linux Mint Debian, PopOS, etc., al fin y al cabo se parecen).

## Equipo

```test
OS: LMDE 6 Faye
Kernel: x86_64 Linux 6.1.0-16-amd64
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
$ apt install python3-setuptools ansible git
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
  - ~~telegram~~
  - ~~discord~~
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
  - omz
- security
  - ufw
- network
  - dns
