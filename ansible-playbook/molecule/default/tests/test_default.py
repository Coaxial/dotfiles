"""Role testing files using testinfra."""
import re


def test_ssh_keypair(host):
    keys = [
        host.file("/home/ansible/.ssh/id_ed25519"),
        host.file("/home/ansible/.ssh/id_ed25519.pub")
    ]
    dir = host.file("/home/ansible/.ssh")

    for key in keys:
        assert key.exists
        assert key.user == "ansible"
        assert key.group == "ansible"
        assert key.mode == 0o600

        assert keys[1].contains("test@example.org")

    assert dir.exists
    assert dir.user == "ansible"
    assert dir.group == "ansible"
    assert dir.mode == 0o700

def test_git(host):
    git = host.package("git")

    assert git.is_installed

def test_git_local_config(host):
    gitconfig=host.file("/home/ansible/.gitconfig_local")

    assert gitconfig.contains("test@example.org")
    assert gitconfig.user == "ansible"
    assert gitconfig.group == "ansible"
    assert gitconfig.mode == 0o600

def test_dotfiles_repo_config(host):
    repo_url = host.run("cd /home/ansible/dotfiles && git config --get remote.origin.url")
    pattern = re.compile(r'^git@.+:[-\w]+/[-\w]+\.git$')

    assert pattern.match(repo_url.stdout)

def test_extra_fonts(host):
    extra_fonts = [
        host.run("fc-list | grep 'Anonymous Pro'").stdout,
        host.run("fc-list | grep 'JuliaMono'").stdout,
        host.run("fc-list | grep 'Terminus'").stdout,
        host.run("fc-list | grep 'icons-in-terminal'").stdout,
    ]

    for font in extra_fonts:
        assert len(font) > 0

def test_dotfiles(host):
    filenames = [
        ".ansible.cfg",
        ".asciinema",
        ".bash_aliases",
        ".bash_prompt",
        ".bashrc",
        ".config/nvim",
        ".config/borgmatic",
        ".config/kitty",
        ".gemrc",
        ".ghc",
        ".gitconfig",
        ".gitignore_global",
        ".gvimrc",
        ".irssi",
        ".maid",
        ".path",
        ".profile",
        ".tmux.conf",
        ".tmux",
        ".vimrc",
    ]

    for filename in filenames:
        dotfile = host.file("/home/ansible/" + filename)
        assert dotfile.linked_to == "/home/ansible/dotfiles/ansible-playbook/files/home/" + filename

def test_neovim(host):
    neovim = host.package('neovim')

    assert neovim.is_installed

def test_neovim_plugins(host):
    plugins_dir = host.file('/home/ansible/.vim/autoload')

    assert plugins_dir.exists

def test_rvm_install(host):
    rvm_version = host.run("bash -l -c 'rvm --version'").stdout
    ruby_version = host.run("bash -l -c 'ruby --version'").stdout
    rvm_version_pattern = re.compile(r'^rvm \d+\.\d+\.\d+ \(latest\)')
    ruby_version_pattern = re.compile(r'^ruby \d+\.\d+\.\d+p\d+')


    assert rvm_version_pattern.match(rvm_version)
    assert ruby_version_pattern.match(ruby_version)

def test_nvm_install(host):
    nvm_version = host.run("bash -l -c 'nvm --version'").stdout
    nvm_version_pattern = re.compile(r'^\d+\.\d+\.\d+')

    assert nvm_version_pattern.match(nvm_version)

def test_backups(host):
    packages = ['borgbackup', 'borgmatic']
    config_files = ['borgmatic.service', 'borgmatic.timer']
    config_dirs = ['/home/ansible/.config/systemd', '/home/ansible/.config/systemd/user']

    assert host.service('borgmatic').is_enabled
    assert host.service('borgmatic').is_running

    for package in packages:
        assert host.package(package).is_installed

    for config_file in config_files:
        file = host.file(config_file)

        assert file.exists
        assert file.user == 'ansible'
        assert file.group == 'ansible'
        assert file.mode == 0o600

    for config_dir in config_dirs:
        d = host.file(config_dir)

        assert d.user == 'ansible'
        assert d.group == 'ansible'
        assert d.mode == 0o700
