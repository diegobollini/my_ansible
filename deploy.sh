#!/usr/bin/env bash

###############################################################################
# Script Name: deploy.sh
# Developer: Diego Bollini
# Description: This script is used to setup ansible on a fresh installation of
#              Ubuntu 22.04 in my personal notebook. It updates the system,
#              installs ansible and git, and clone and apply an ansible role.
# Technologies: Bash, Ubuntu, Ansible, Git, Python, Kubernetes
###############################################################################

# Actualizar sistema
echo "[PREPARAR NOTEBOOK] ACTUALIZAR AMBIENTE DE TRABAJO"
sudo apt-get -y update
sudo apt-get -y upgrade

# Instalar requerimientos
echo "[PREPARAR NOTEBOOK] INSTALAR GIT"
sudo apt-get install -y git

# Instalar dependencias de Ansible
echo '[PREPARAR NOTEBOOK] INSTALAR DEPENDENCIAS'
sudo apt-get install -y python3-setuptools

# Instalar Ansible
echo "[PREPARAR NOTEBOOK] INSTALAR ANSIBLE"
sudo apt-get install -y ansible

echo '[PREPARAR NOTEBOOK] NOTEBOOK LISTA!'

# Deploy projecto Ansible, implementación
echo "[PROYECTO ANSIBLE] CLONAR REPOSITORIO"
sudo touch /var/log/ansible.log
sudo chown -R $USER:$USER /var/log/ansible.log
mkdir /home/$USER/proyectos/
git clone https://github.com/diegobollini/my_ansible.git /home/$USER/proyectos/my_ansible
cd proyectos/my_ansible

# Para ejecutar el rol base
function launch {
    read -e -p "COMENZAR IMPLEMENTACIÓN? ( 'si', 'no' ): " LAUNCH_OPTION

    while [[ "$LAUNCH_OPTION" != "si" && "$LAUNCH_OPTION" != "no" ]]; do
        read -e -p "Por favor seleccionar una opción correcta ( 'si', 'no' ): " LAUNCH_OPTION
    done

    if [[ "$LAUNCH_OPTION" == "si" ]]; then
        ansible-playbook playbooks/notebook.yml -K --verbose
    fi

    if [[ "$LAUNCH_OPTION" == "no" ]]; then
        read -e -p "Gracias por lanzar el proyecto, ver README.md para más información."
    fi

}

launch
