# OpenConnect and OpenSSH Server Docker Image

This Docker image sets up an Alpine-based container running OpenConnect (a VPN client) and OpenSSH. It allows users to connect to a specified VPN server and access the container via SSH.

## Features

- **OpenConnect VPN Client**: Connect to a VPN server using OpenConnect with support for user credentials and server certificate pinning.
- **OpenSSH Server**: SSH access with root login enabled.
- **Environmental Variables**: Configure VPN connection parameters via environment variables.

## Environment Variables

- `VPN_SERVER`: The VPN server address.
- `VPN_USERNAME`: The VPN username.
- `VPN_PASSWORD`: The VPN password.
- `VPN_SERVERCERT`: The server certificate pin for the VPN server.

## Usage

Run the Docker Container

To run the container, use the following command:

```sh
docker run -it --privileged -p 2222:22 \
    -e VPN_SERVER="vpn.example.com" \
    -e VPN_USERNAME="user" \
    -e VPN_PASSWORD="password" \
    -e VPN_SERVERCERT="pin-sha256:Jyeq2EUWNeXSybL44qOXYSmZt/1YnMGgWi0mskRNJJo=" \
    --name openconnect-vpn morgan404/openconnect-client
```


Note: This image requires the --privileged flag to run OpenConnect successfully.

