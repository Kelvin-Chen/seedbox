# Seedbox
This project helps you run a seedbox and media server in Docker.

## Included Applications
| Application          | Web Interface           |
-----------------------|-------------------------|
| Plex                 | plex.yourdomain.com     |
| rtorrent + ruTorrent | rtorrent.yourdomain.com |
| Sonarr               | sonarr.yourdomain.com   |
| Radarr               | radarr.yourdomain.com   |
| Jackett              | jackett.yourdomain.com  |
| OpenVPN              | ----------------------- |

## Dependencies
- [Docker](https://github.com/docker/docker) >= 1.13.0
- [Docker Compose](https://github.com/docker/compose) >= 1.10.0

## Quickstart

### Config
Copy `config.default` to `config` and edit the variables inside.

### Starting
```sh
docker-compose pull
docker-compose up -d
```
### Where is my data?
Config files are stored in the `seedbox_config` volume and
other data is stored in the `seedbox_data` volume. You can
change this by editing the `docker-compose.yml` file.

## Plex
If you own PlexPass, you can get the docker image to auto-update to the latest
PlexPass version when the container starts up. Simply set the `PLEX_TOKEN`
variable in the config file.

## OpenVPN
Go [here](https://github.com/kelvin-containers/openvpn) for more information
on how to configure OpenVPN and generate more certificates.
