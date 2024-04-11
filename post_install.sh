#!/bin/tcsh


echo "install Homebox"
# pip install --root-user-action=ignore /root/crypto/pycparser-2.21-py2.py3-none-any.whl
# pip install --root-user-action=ignore /root/crypto/cffi-1.16.0-cp39-cp39-freebsd_13_1_release_p9_amd64.whl
# pip install --root-user-action=ignore /root/crypto/cryptography-42.0.2-cp39-cp39-freebsd_13_1_release_p9_amd64.whl
# python3 -m pip install --user --root-user-action=ignore --no-warn-script-location ansible-core
# echo "Update PATH"
# set path = ( $path /root/.local/bin )
# setenv ANSIBLE_INVENTORY_UNPARSED_WARNING False
# setenv ANSIBLE_LOCALHOST_WARNING False
# # ansible-galaxy collection install community.general
# echo "Run install instructions using Ansible"
# ansible-playbook /root/homebox.yaml


# npm install -g pnpm
# go install golang.org/dl/go1.22.0@latest
# go/bin/go1.22.0 download
# ln -s /root/sdk/go1.22.0/bin/go /usr/local/bin/go122
# ln -s /root/sdk/go1.22.0/bin/gofmt  /usr/local/bin/gofmt122

# fetch https://github.com/0xJacky/nginx-ui/archive/refs/tags/v2.0.0-beta.14.tar.gz
# tar -xvf v2.0.0-beta.14.tar.gz
# mv nginx-ui-2.0.0-beta.14 nginx-ui
# cd nginx-ui/app
# sed -i bak '1 r /root/package_fix.sed' package.json

# pnpm install
# pnpm build

# cd ..
# go122 build -o nginx-ui -v main.go
# cp app.example.ini app.ini
# echo "Install pnpm"
npm install -g pnpm
set status = $status
if ($status != 0) then
    echo "pnmp install failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "pnmp install succeeded"
    echo ""
endif

echo ""
hash -r
rehash
# echo "Install go1.22"
go install golang.org/dl/go1.22.0@latest
set status = $status
if ($status != 0) then
    echo "Go122 install failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Go122 install succeeded"
    echo ""
endif

/root/go/bin/go1.22.0 download
set status = $status
if ($status != 0) then
    echo "Go122 download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Go122 download succeeded"
    echo ""
endif

ln -s /root/sdk/go1.22.0/bin/go /usr/local/bin/go122
set status = $status
if ($status != 0) then
    echo "Go122 linkning failed"
    # Optionally, exit or handle the error
    #exit 1
else
    echo ""
    echo "Go122 linking succeeded"
    echo ""
endif

ln -s /root/sdk/go1.22.0/bin/gofmt /usr/local/bin/gofmt122
set status = $status
if ($status != 0) then
    echo "gofmt122 linking failed"
    # Optionally, exit or handle the error
    #exit 1
else
    echo ""
    echo "gofmt122 linking succeeded"
    echo ""
endif
hash -r
rehash
# echo "Fetch and install HomeBox"
cd /root && git clone https://github.com/hay-kot/homebox.git
set status = $status
if ($status != 0) then
    echo "Homebox download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Homebox download succeeded"
    echo ""
endif

setenv NUXT_TELEMETRY_DISABLED 1 # disable telemetry request
cd /root/homebox/frontend && pnpm install --frozen-lockfile --shamefully-hoist
set status = $status
if ($status != 0) then
    echo "Frontend dependency install failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Frontend dependency install succeeded"
    echo ""
endif

cd /root/homebox/frontend && pnpm build
set status = $status
if ($status != 0) then
    echo "Frontend build failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Frontend build succeeded"
    echo ""
endif

cd /root/homebox/backend && go122 get -d -v ./...
set status = $status
if ($status != 0) then
    echo "Backend dependency download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Backend dependency download succeeded"
    echo ""
endif

cd /root/homebox/backend && rm -rf ./app/api/public

cd /root/homebox/backend && cp -r /root/homebox/frontend/.output/public/ /root/homebox/backend/app/api/static/public/
set status = $status
if ($status != 0) then
    echo "Copy frontend static failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Copy frontend static succeeded"
    echo ""
endif

setenv CGO_ENABLED 0
setenv GOOS freebsd
go122 build \
      -ldflags "-s -w -X main.commit=head -X main.buildTime=0001-01-01T00:00:00Z -X main.version='3.2'" \
      -o ./go/bin/api \
      -v ./app/api/*.go

set status = $status
if ($status != 0) then
    echo "Backend build failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Backend build succeeded"
    echo ""
endif

mkdir -p /root/homebox/app
cd /root/homebox && cp backend/go/bin/api ./app/
set status = $status
if ($status != 0) then
    echo "Copy app binary failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Copy app binary succeeded"
    echo ""
endif

cd /root/homebox && chmod +x ./app/api/

cd /root/homebox && mkdir -p /root/homebox/data
set status = $status
if ($status != 0) then
    echo "Copy app binary failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Copy app binary succeeded"
    echo ""
endif

# echo "Enable nginx service"
sysrc -f /etc/rc.conf nginx_enable=YES
service nginx start
sysrc -f /etc/rc.conf mdnsresponderposix_enable=YES
sysrc -f /etc/rc.conf mdnsresponderposix_flags="-f /usr/local/etc/mdnsresponder.conf"
service mdnsresponderposix start
sysrc -f /etc/rc.conf homebox_enable=YES
sysrc -f /etc/rc.conf homebox_env="HBOX_MODE=production HBOX_STORAGE_DATA=/root/homebox/data/ HBOX_STORAGE_SQLITE_URL='/root/homebox/data/homebox.db?_pragma=busy_timeout=2000&_pragma=journal_mode=WAL&_fk=1'"
service homebox start


echo "There is no default username and password, register new user with your credentials." >> /root/PLUGIN_INFO
