#!/bin/bash
# start_openvswitch.sh

# Enter number of network interface
echo -n "[AVEES-Cluster] Enter number of ethernets : "
read number_of_ethernet

# Check that node_index is integer type
case ${number_of_ethernet} in
''|*[!0-9]*) 
	echo "[AVEES-Cluster] You didn't enter number"
	exit 1 ;;
esac

# Set network interface up
for var in $(seq 0 $(expr ${number_of_ethernet} - 1))
do
  echo "Set eth${var} to 192.168.2.${AVEES_CLUSTERING_NODE_ID}$(expr ${var} + 1)"
  sudo ifconfig eth${var} 192.168.2.${AVEES_CLUSTERING_NODE_ID}$(expr ${var} + 1)
done

# Open vSwitch Start
if [ ! -e /usr/local/etc/openvswitch/conf.db ]; then
  cd ~/ovs
  sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
fi
sudo mkdir -p /usr/local/var/run/openvswitch
export PATH=$PATH:/usr/local/share/openvswitch/scripts
sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach --log-file
sudo ovs-vsctl --no-wait init
sudo ovs-vswitchd --pidfile --detach

# Set openvswitch bridge
sudo ovs-vsctl del-br br${AVEES_CLUSTERING_NODE_ID}
sudo ovs-vsctl add-br br${AVEES_CLUSTERING_NODE_ID} -- set bridge br${AVEES_CLUSTERING_NODE_ID} datapath_type=netdev
sudo ovs-vsctl set bridge br${AVEES_CLUSTERING_NODE_ID} stp_enable=true
sudo ovs-vsctl set-fail-mode br${AVEES_CLUSTERING_NODE_ID} standalone
sudo ovs-vsctl set-controller br${AVEES_CLUSTERING_NODE_ID} tcp:192.168.1.5:6633

for var in $(seq 0 $(expr ${number_of_ethernet} - 1))
do
  echo "openvswitch add port eth${var}"
  sudo ovs-vsctl add-port br${AVEES_CLUSTERING_NODE_ID} eth${var}
done

# Set openvswitch interface up
sudo ifconfig br${AVEES_CLUSTERING_NODE_ID} 192.168.2.${AVEES_CLUSTERING_NODE_ID}0
