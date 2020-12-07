verbosity ?=
.PHONY: all install_reqs playbook_run clean limit_info editvars

all: limit_info playbook_run

limit_info:
	@echo 'Running against: $(limit)'

install_reqs:
	@echo 'Fetching dependencies...'
	@if [ -s requirements.yml ]; then \
		ansible-galaxy install -r requirements.yml --force; \
	fi

# ask user for vault pass and save it with mode 0600, unless it's already saved.
.vault_password:
	@stty -echo; \
	read -p ".vault_password missing, enter vault password: " vpwd; \
	stty echo; \
	echo $$vpwd > .vault_password; \
	chmod 600 .vault_password; \
	echo

vars/vars.yml: .vault_password
	@ansible-vault create vars/vars.yml --vault-password-file .vault_password

editvars: vars/vars.yml
	@ansible-vault edit vars/vars.yml --vault-password-file .vault_password

playbook_run: .vault_password install_reqs
	@ansible-playbook -i inventory main.yml --vault-password-file .vault_password $(verbosity)
	@- rm -f playbook.retry

clean:
	@-rm -f .vault_password
