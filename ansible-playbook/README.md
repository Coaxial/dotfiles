# Install

Requires the pip modules:
- molecule-docker
- molecule[lint,ansible]
- ansible
- pytest-testinfra

1. Install ansible (apt or pip3).

2. Review variables: `$EDITOR vars/vars.yml` and `make editvars`.

3. Enable passwordless sudo for user: `echo -e "${USER} ALL=(ALL)\tNOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/90-"${USER}"`

4. Upgrade the OS

5. Run playbook: `make playbook_run`
