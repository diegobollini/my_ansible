# Laboratorio Ansible

Proyecto de Ansible para automatizar la preparación de mi notebook personal. Objetivo: **Debian 13 (trixie)**.

## Preparación

```bash
# Deploy con script (actualiza el sistema, instala Ansible y clona el repo)
$ sudo apt install -y curl
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/diegobollini/my_ansible/master/deploy.sh)"
```

### Deploy manual

```bash
# Dependencias
$ sudo apt install -y python3-setuptools ansible git stow
# Clonar repositorio con playbooks, tasks, etc.
$ git clone https://github.com/diegobollini/my_ansible && cd my_ansible
# Instalar colecciones de Ansible Galaxy requeridas (community.general)
$ ansible-galaxy collection install -r requirements.yml
# Deployar rol
$ ansible-playbook playbooks/notebook.yml -K --verbose
# También pueden usarse tags para tareas específicas
$ ansible-playbook playbooks/notebook.yml --tags=github_cli,packages_dev -K --verbose
```

## Configuración privada (SSH)

`roles/diego/files/ssh_config` es la config de SSH pública y versionada. Los hosts
privados propios (IPs, usuarios, puertos de servidores) **no se versionan**: viven en
`~/.ssh/config.local` en cada máquina, incluido desde `ssh_config` vía `Include`. El
playbook crea ese archivo vacío si no existe; los hosts privados se agregan a mano
después del primer deploy.

## Post instalación

Algunos comandos y tareas artesanales pendientes de automatizar:

```bash
# Configurar ssh en github
$ gh auth login
$ gh ssh-key add ~/.ssh/private_key_diego.pub
# Validar: https://github.com/diegobollini.keys
```

## Tareas y tags

- `packages` (umbrella): `packages_system`, `packages_compression`, `packages_other`, `packages_hardware`, `packages_performance`, `packages_dev`
- `chrome`, `firefox`
- `language`
- `telegram`, `discord`
- `appearence_wallpaper`, `appearence_gnome`
- `ssh`
- `code`
- `python3`
- `docker`
- `git` (umbrella): `github_cli`, `git_config`
- `meld`
- `zsh`, `omz`
- `ufw`
- `dns`
- `extensions`, `dock`

## Estructura

```
roles/diego/
  vars/main.yml     # variables del rol (usuario, git, locale, DNS, extensiones)
  handlers/main.yml # handlers (ej: restart NetworkManager)
  tasks/            # una tarea por área, importadas desde tasks/main.yml
  files/            # dotfiles y assets estáticos
```

## Calidad

El repo corre `ansible-lint` (perfil `production`) y un chequeo de sintaxis en CI
(ver [`.github/workflows/ci.yml`](.github/workflows/ci.yml)), además de una
validación de que los paquetes apt usados existan realmente en los repos de
Debian trixie (`scripts/check_debian_packages.py`).

```bash
$ pip install ansible-core ansible-lint
$ ansible-galaxy collection install -r requirements.yml
$ ansible-lint
$ ansible-playbook playbooks/notebook.yml --syntax-check
```

## Testeando con [vagrant](https://vagrantup.com)

- [Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search)
- Levantar, ejecutar, acceder, etc.:

```sh
$ vagrant init debian/trixie64
$ vagrant up
$ vagrant ssh
$ logout
$ vagrant box list
#
$ vagrant snapshot save default trixie-base
$ vagrant snapshot restore default trixie-base
$ vagrant snapshot list
$ vagrant global-status
#
$ vagrant destroy
```
