# Install

Requires the pip modules:
- molecule-docker
- molecule[lint,ansible]
- ansible
- pytest-testinfra

Install ansible (apt or pip3).

Review variables: `$EDITOR vars/vars.yml` and `make editvars`.

Run playbook: `make playbook_run`
