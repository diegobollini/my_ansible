#!/usr/bin/env python3
"""Valida que los paquetes apt referenciados en roles/diego/tasks existan en
los repos oficiales de Debian (main, contrib, non-free, non-free-firmware).

Uso: check_debian_packages.py <Packages_file> [<Packages_file> ...]
Los archivos Packages se descargan previamente (ver .github/workflows/ci.yml).
"""

import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
TASKS_DIR = ROOT / "roles" / "diego" / "tasks"

# Paquetes que se instalan desde repos de terceros agregados por el propio
# playbook (Docker, Google, GitHub CLI) y por lo tanto no están en los repos
# oficiales de Debian.
EXTERNAL_REPO_PACKAGES = {
    "docker-ce",
    "docker-compose-plugin",
    "google-chrome-stable",
    "gh",
}

APT_MODULES = {"apt", "ansible.builtin.apt"}


def iter_tasks(data):
    if isinstance(data, list):
        for item in data:
            yield from iter_tasks(item)
    elif isinstance(data, dict):
        yield data
        for key in ("block", "rescue", "always"):
            if key in data:
                yield from iter_tasks(data[key])


def extract_names(task):
    module_key = next((k for k in task if k in APT_MODULES), None)
    if not module_key:
        return []
    args = task[module_key]
    if not isinstance(args, dict):
        return []
    names = args.get("name", args.get("pkg"))
    if isinstance(names, str) and names.startswith("{{") and names.endswith("}}"):
        var_name = names.strip("{} ")
        names = task.get("vars", {}).get(var_name)
    if names is None:
        return []
    if isinstance(names, str):
        return [names]
    if isinstance(names, list):
        return [n for n in names if isinstance(n, str)]
    return []


def main():
    if len(sys.argv) < 2:
        print("uso: check_debian_packages.py <Packages_file> [...]", file=sys.stderr)
        return 2

    available = set()
    for packages_file in sys.argv[1:]:
        with open(packages_file, encoding="utf-8", errors="replace") as f:
            for line in f:
                if line.startswith("Package: "):
                    available.add(line.strip().split(" ", 1)[1])

    referenced = set()
    for task_file in sorted(TASKS_DIR.glob("*.yml")):
        with open(task_file, encoding="utf-8") as f:
            data = yaml.safe_load(f)
        if not data:
            continue
        for task in iter_tasks(data):
            referenced.update(extract_names(task))

    to_check = referenced - EXTERNAL_REPO_PACKAGES
    missing = sorted(p for p in to_check if p not in available)

    print(f"Paquetes referenciados: {len(referenced)} (externos ignorados: {len(referenced & EXTERNAL_REPO_PACKAGES)})")
    if missing:
        print("Paquetes NO encontrados en los repos de Debian:")
        for p in missing:
            print(f"  - {p}")
        return 1

    print("OK: todos los paquetes existen en los repos de Debian consultados.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
