# Cloud Storage (with Google Drive)

Set up rclone based on the config below.
Basically, the structure is Google Drive => cache => encryption.

After setting up rclone, copy the systemd unit files over to `/etc/systemd/system` and enable/start them.

```
[gcache]
type = cache
remote = gdrive:
plex_url =
plex_username =
plex_password =
chunk_size = 10M
info_age = 168h
chunk_total_size =

[gcrypt]
type = crypt
remote = gcache:encrypted
filename_encryption = standard
directory_name_encryption = true
password =
password2 =

[gdrive]
type = drive
client_id =
client_secret =
scope = drive
root_folder_id =
service_account_file =
token =
team_drive =
```

## Directory Structure
1. Union(rclone mount, `/data`) => `/mnt/cloud`
2. `/mnt/cloud` => `/cloud` in Docker
3. `/data/.downloads` => `/downloads` in Docker (rtorrent container only)

The downloads mount (3) is mounted as a workaround since rtorrent won't directly
download to the UnionFS mount (2). To make sure Sonarr/Radarr imports everything
correctly and works with hard links, make sure to set downloads directory to
`/downloads` and create a path mapping with the values below:

| Host     | Remote Path | Local Path         |
-----------|-------------|--------------------|
| rtorrent | /downloads/ | /cloud/.downloads/ |
