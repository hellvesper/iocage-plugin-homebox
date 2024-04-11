# iocage-plugin-homebox

Artifact files for Homebox iocage plugin

site: https://hay-kot.github.io/homebox/
github: https://github.com/hay-kot/homebox

The plugin script will install latest version from master branch of app repository

To install:

- ssh to your TrueNAS or open **Shell** in Web UI
- download plugin `fetch https://raw.githubusercontent.com/hellvesper/iocage-plugin-homebox/master/homebox.json`
- launch installation `iocage fetch -P homebox.json -n homebox` where `homebox` - your plugin jail name.

After installation you can open nginx-ui using ip address or mdns domain adress which will equal jail name. For example above mdns adress will be `http:/homebox.local`

Note:

Plugin configured to use `DHCP`, so it will acquire new `IP` adress from you router which will differ from your **NAS** IP
