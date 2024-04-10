#!/bin/tcsh


echo "install Homebox"
pip install --root-user-action=ignore /root/crypto/pycparser-2.21-py2.py3-none-any.whl
pip install --root-user-action=ignore /root/crypto/cffi-1.16.0-cp39-cp39-freebsd_13_1_release_p9_amd64.whl
pip install --root-user-action=ignore /root/crypto/cryptography-42.0.2-cp39-cp39-freebsd_13_1_release_p9_amd64.whl
python3 -m pip install --user --root-user-action=ignore --no-warn-script-location ansible-core
echo "Update PATH"
set path = ( $path /root/.local/bin )
setenv ANSIBLE_INVENTORY_UNPARSED_WARNING False
setenv ANSIBLE_LOCALHOST_WARNING False
# ansible-galaxy collection install community.general
echo "Run install instructions using Ansible"
ansible-playbook /root/homebox.yaml


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

echo "The default username and password for this install is admin for both" >> /root/PLUGIN_INFO
