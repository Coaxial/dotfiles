"""Role testing files using testinfra."""
import re

def test_backups(host):
    packages = ['borgbackup', 'borgmatic']
    config_files = ['borgmatic.service', 'borgmatic.timer']
    config_dir = '/home/ansible/.config/systemd/user/timers.target.wants'
    enabled_timer = host.file('/home/ansible/.config/systemd/user/timers.target.wants/borgmatic.timer')

    for package in packages:
        assert not host.package(package).is_installed

    for config_file in config_files:
        file = host.file('/home/ansible/.config/systemd/user/' + config_file)

        assert not file.exists

    d = host.file(config_dir)
    assert not d.exists

    assert not enabled_timer.exists
