# iocage-plugin-nginx-ui
Artifact files for nginx-ui iocage plugin

To install:
* ssh to your TrueNAS or open **Shell** in Web UI
* download plugin `fetch https://raw.githubusercontent.com/hellvesper/iocage-plugin-nginx-ui/master/nginx-ui.json`
* launch installation `iocage fetch -P nginx-ui.json -n nginx-ui` where `nginx-ui` - your plugin jail name.

After installation you can open nginx-ui using ip address or mdns domain adress which will equal jail name. For example above mdns adress will be `http://nginx-ui.local` 

Note:

Plugin configured to use `DHCP`, so it will acquire new `IP` adress from you router which will differ from your **NAS** IP

