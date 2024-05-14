# Keepalived Installation Script

This Bash script automates the installation and configuration of Keepalived on Debian-based systems. It has been specifically designed to quickly deploy Keepalived in Proxmox LXC and VMs but should work on other Debian 11/12 systems as well.

## Installation

To install Keepalived using this script, follow these steps:
```bash
curl -s https://raw.githubusercontent.com/medabida/deploy-keepalived/main/install.sh | bash -s <vrrp_instance_name> <interface> <virtual_router_id> <priority> <virtual_ip1> [<virtual_ip2> ...]
```

Example:
```bash
curl -s https://raw.githubusercontent.com/medabida/deploy-keepalived/main/install.sh | bash -s gateway1 eth0 12 101 12.0.1.11/24 12.0.1.12/24
```

## Arguments

- `<vrrp_instance_name>`: Name of the VRRP instance.
- `<interface>`: the interface to use.
- `<virtual_router_id>`: ID of the virtual router.
- `<priority>`: Priority of the instance.
- `<virtual_ip1> [<virtual_ip2> ...]`: List of virtual IP addresses.

## Compatibility

This script has been tested on Debian 11 and Debian 12 systems within Proxmox LXC and VM environments. However, it should work on other Debian-based systems outside the scope of Proxmox.

## License

This script is licensed under the [MIT License](LICENSE).
