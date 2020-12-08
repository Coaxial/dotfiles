# Install

Requires the pip modules:
- molecule-docker
- molecule[lint,ansible]
- ansible
- pytest-testinfra

1. Install ansible (apt or pip3).

2. Review variables: `$EDITOR vars/vars.yml` and `make editvars`.

3. Enable passwordless sudo (assuming the `sudo` group is named `sudo`): `sed -i "/^%sudo/s/ALL\$/NOPASSWD:ALL/g" /etc/sudoers`

4. Run playbook: `make playbook_run`
