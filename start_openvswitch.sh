#!/bin/bash
# start_openvswitch.sh

# Open vSwitch Start
if [-e /usr/local/etc/openvswitch/conf.db]; then
  cd ~/ovs
  sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
fi
sudo mkdir -p /usr/local/var/run/openvswitch
export PATH=$PATH:/usr/local/share/openvswitch/scripts
sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach --log-file
sudo ovs-vsctl --no-wait init
sudo ovs-vswitchd --pidfile --detach
