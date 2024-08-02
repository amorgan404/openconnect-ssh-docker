# Use the official Alpine base image
FROM alpine:3.16.8
# Script to run OpenConnect and SSH
COPY run.sh /run.sh
# Install OpenSSH and OpenConnect
RUN apk update && \
    apk add --no-cache openssh openssl openconnect && \
# Create the SSH directory and generate host keys
    mkdir /var/run/sshd && \
    ssh-keygen -A && \
# Set the root password (replace 'yourpassword' with a secure password)
    echo 'root:mypassword' | chpasswd && \
# Allow root login by modifying the SSH config
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config && \
    chmod +x /run.sh
# Expose the SSH port
EXPOSE 22
# Set the entrypoint to the script
ENTRYPOINT ["/bin/sh", "/run.sh"]
