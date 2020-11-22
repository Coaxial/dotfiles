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
    pattern = re.compile("^git@.+:[-\w]+/[-\w]+\.git$")

    assert pattern.match(repo_url.stdout)

def test_extra_fonts(host):
    extra_fonts = [
        # TODO: Uncomment when archive is fixed
        # host.run("fc-list | grep 'Anonymous Pro'").stdout,
        host.run("fc-list | grep 'JuliaMono'").stdout,
        host.run("fc-list | grep 'Terminus'").stdout,
        host.run("fc-list | grep 'icons-in-terminal'").stdout,
    ]

    for font in extra_fonts:
        assert len(font) > 0
