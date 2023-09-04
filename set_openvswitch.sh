#!/bin/bash
# set_openvswitch.sh

echo -n "[AVEES-Cluster] Enter number of ethernets : "
read number_of_ethernet

# Check that node_index is integer type
case ${number_of_ethernet} in
''|*[!0-9]*) 
	echo "[AVEES-Cluster] You didn't enter number"
	exit 1 ;;
esac

# Set network interface
for var in {0..${number_of_ethernet}}
do
  echo "Set eth${var} to 192.168.2.${number_of_ethernet}$(expr ${var}+1)"
done
