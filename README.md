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

## Usage

Run the Docker Container

To run the container, use the following command:

```
docker run -it -d --privileged -p 222:22 \
    -e VPN_SERVER="vpn.example.com" \
    -e VPN_USERNAME="user" \
    -e VPN_PASSWORD="password" \
    --name openconnect-vpn morgan404/openconnect-client
```
## You can use the container as a proxy to SSH into the VPN network. Use the following command:
SSH into VPN network using the container as a proxy

## Architecture Diagram
```
+--------+               +----------------------+           +-------------+
|        |               |                      |           |             |
|  User  +-- SSH Proxy --> OpenConnect Container +-- VPN -->   VPN Server |
|        |               |                      |           |             |
+--------+               +----------------------+           +-------------+
                                                                 |
                                                                 |
                                                                 v
                                                         +-------------+
                                                         |             |
                                                         |  SSH Server |
                                                         |             |
                                                         +-------------+

```
```
ssh -o "ProxyCommand=ssh -W %h:%p root@localhost -p 222" user@192.168.0.10
```

### Default Root password for the container is "mypassword" without quotation

### Note: This image requires the --privileged flag to run OpenConnect successfully.

## Changelog

### [1.1] - 2024-08-02
- **Removed `-e VPN_SERVERCERT=` Variable**: The `VPN_SERVERCERT` environment variable is no longer required as it is now automatically obtained from `VPN_SERVER`.
  - This simplifies the configuration process and reduces the chance of misconfiguration.
  - Usage example has been updated to reflect this change.

  #### Before
  ```sh
  docker run -e VPN_SERVER=example.com -e VPN_SERVERCERT="pin-sha256:Jyeq2EIRLeXSyb654qOFYSmZt/1YnMGgWi0mskRNJJo=" morgan404/openconnect-client:1.0

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/amorgan404/openconnect-ssh-docker?tab=MIT-1-ov-file#) file for details.
