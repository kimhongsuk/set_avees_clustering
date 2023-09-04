#!/bin/bash
# mid_start_openvswitch.sh

# Enter number of network interface
echo -n "[AVEES-Cluster] Enter number of ethernets : "
read number_of_ethernet

# Check that node_index is integer type
case ${number_of_ethernet} in
''|*[!0-9]*) 
	echo "[AVEES-Cluster] You didn't enter number"
	exit 1 ;;
esac

# Set network interface down
for var in $(seq 0 $(expr ${number_of_ethernet} - 1))
do
  echo "Set eth${var} down"
  sudo ifconfig eth${var} 0
done
