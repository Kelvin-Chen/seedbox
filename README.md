# Seedbox
A collection of Dockerfiles and docker-compose configuration to set up a
seedbox.

## Accessing the available WebUIs
Go to `X.domain` where `X` is the item you want to access.
Included items are:
- rtorrent
- sickrage
- syncthing
- plex
- openvpn

The front-end reverse proxy routes based on the lowest level subdomain (e.g.
`rtorrent.example.com` would route to rtorrent). Since this is how the router
works, it is recommended for you to get a top level domain. If you do not have
one, you can edit your domains locally by changing your hosts file or use a
browser plugin that changes the host header.

Note: Plex is also available directly through the `32400` port without going
through the reverse proxy. You will have to sign in with your plex.tv account
if you do this.

## Running

First, you need to create the network `seedbox` to allow containers to communicate between
each others.

    $ docker network create seedbox

```sh
$ docker-compose pull
$ docker-compose --x-networking up -d
```
Make sure you install the dependencies and finish configuration before doing
this.

You may optionally build the images yourself instead of pulling by running
`./build-all.sh`.

## Dependencies
- [Docker](https://github.com/docker/docker)
- [Docker Compose](https://github.com/docker/compose) >=v1.6.0

## Configuration
Copy the `config.default` file to `config` and change the variables as desired.
The variables are all self-explanatory.

If you want to enable SSL, you would need to have your certificate and key be
at `/config/frontend/ssl.crt` and `/config/frontend/ssl.key` respectively.  The
frontend image includes a command `ssl-gen` to automatically create self signed
certificates for you.

## Where is my data?
All data are saved in the docker volumes `seedbox_config` or
`seedbox_torrents`.  
You can also replace these docker volumes with static path if you want to handle manually
where files are stored on your server.

## OpenVPN
The OpenVPN container generates a single client key/cert pair by default.
Run the command below to get your OpenVPN config file:
```sh
$ docker exec seedbox_openvpn_1 create-client client >> client.ovpn
```
Edit the `client.ovpn` and replace the line `remote MYSERVER_HOST 1194` with
the hostname or IP address of your server.

You can also create more certs by by docker exec-ing into the container and
using easy-rsa.
