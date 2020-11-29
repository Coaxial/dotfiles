"""Role testing files using testinfra."""
import re


def test_ssh_keypair(host):
    keys = [
        host.file("/root/.ssh/id_ed25519"),
        host.file("/root/.ssh/id_ed25519.pub")
    ]

    for key in keys:
        assert key.exists
        assert key.user == "root"
        assert key.group == "root"
        assert key.mode == 0o600

        assert keys[1].contains("test@example.org")

def test_git(host):
    git = host.package("git")

    assert git.is_installed

def test_git_local_config(host):
    gitconfig=host.file("/root/.gitconfig_local")

    assert gitconfig.contains("test@example.org")
    assert gitconfig.user == "root"
    assert gitconfig.group == "root"
    assert gitconfig.mode == 0o600

def test_dotfiles_repo_config(host):
    repo_url = host.run("cd /root/dotfiles && git config --get remote.origin.url")
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
        dotfile = host.file("/root/" + filename)
        assert dotfile.linked_to == "/root/dotfiles/ansible-playbook/files/home/" + filename

def test_neovim(host):
    neovim = host.package('neovim')

    assert neovim.is_installed

def test_neovim_plugins(host):
    plugins_dir = host.file('/root/.vim/autoload')

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
