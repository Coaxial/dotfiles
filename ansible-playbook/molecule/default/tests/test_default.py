"""Role testing files using testinfra."""


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
