#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

# Check if all required arguments are provided
if [ $# -lt 4 ]; then
    echo "Usage: $0 <vrrp_instance_name> <interface> <virtual_router_id> <priority> <virtual_ip1> [<virtual_ip2> ...]"
    exit 1
fi

VRRP_INSTANCE=$1
INTERFACE=$2
VIRTUAL_ROUTER_ID=$3
PRIORITY=$4
shift 4
VIRTUAL_IPS=("$@")

# Update package index
apt update

# Install required packages
apt install -y keepalived

# Check if installation was successful
if [ $? -ne 0 ]; then
    echo "Failed to install Keepalived. Please check for errors."
    exit 1
fi

# Create Keepalived configuration file
cat <<EOF > /etc/keepalived/keepalived.conf
vrrp_instance $VRRP_INSTANCE {
    state BACKUP
    interface $INTERFACE
    virtual_router_id $VIRTUAL_ROUTER_ID
    priority $PRIORITY
    virtual_ipaddress {
EOF

# Add virtual IP addresses to configuration file
for ip in "${VIRTUAL_IPS[@]}"; do
    echo "        $ip" >> /etc/keepalived/keepalived.conf
done

# Complete configuration file
echo "    }" >> /etc/keepalived/keepalived.conf
echo "}" >> /etc/keepalived/keepalived.conf

# Check if configuration file was created successfully
if [ $? -ne 0 ]; then
    echo "Failed to create Keepalived configuration file. Please check for errors."
    exit 1
fi

# Optional: Start Keepalived service
systemctl start keepalived

# Optional: Enable Keepalived to start on boot
systemctl enable keepalived

echo "Keepalived setup complete"
