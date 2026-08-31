#!/usr/bin/env bash

###############################################################################
# Script Name: deploy.sh
# Developer: Diego Bollini
# Description: Prepara una instalación fresca de Debian 13 (trixie) en mi
#              notebook personal: actualiza el sistema, instala Ansible y
#              git, clona este repositorio y aplica el playbook.
# Technologies: Bash, Debian, Ansible, Git
###############################################################################

set -euo pipefail

REPO_URL="https://github.com/diegobollini/my_ansible.git"
PROJECTS_DIR="${HOME}/proyectos"
PROJECT_DIR="${PROJECTS_DIR}/my_ansible"

echo "[PREPARAR NOTEBOOK] ACTUALIZAR AMBIENTE DE TRABAJO"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "[PREPARAR NOTEBOOK] INSTALAR GIT Y STOW"
sudo apt-get install -y git stow

echo "[PREPARAR NOTEBOOK] INSTALAR DEPENDENCIAS"
sudo apt-get install -y python3-setuptools

echo "[PREPARAR NOTEBOOK] INSTALAR ANSIBLE"
sudo apt-get install -y ansible

echo "[PREPARAR NOTEBOOK] NOTEBOOK LISTA!"

echo "[PROYECTO ANSIBLE] CLONAR REPOSITORIO"
sudo touch /var/log/ansible.log
sudo chown "${USER}:${USER}" /var/log/ansible.log
mkdir -p "${PROJECTS_DIR}"

if [[ -d "${PROJECT_DIR}/.git" ]]; then
    echo "El repositorio ya existe en ${PROJECT_DIR}, se omite el clone."
else
    git clone "${REPO_URL}" "${PROJECT_DIR}"
fi

cd "${PROJECT_DIR}"

echo "[PROYECTO ANSIBLE] INSTALAR COLECCIONES DE ANSIBLE GALAXY"
ansible-galaxy collection install -r requirements.yml

function launch {
    read -r -e -p "COMENZAR IMPLEMENTACIÓN? ( 'si', 'no' ): " LAUNCH_OPTION

    while [[ "$LAUNCH_OPTION" != "si" && "$LAUNCH_OPTION" != "no" ]]; do
        read -r -e -p "Por favor seleccionar una opción correcta ( 'si', 'no' ): " LAUNCH_OPTION
    done

    if [[ "$LAUNCH_OPTION" == "si" ]]; then
        ansible-playbook playbooks/notebook.yml -K --verbose
    else
        echo "Gracias por lanzar el proyecto, ver README.md para más información."
    fi
}

launch
