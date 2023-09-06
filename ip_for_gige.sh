#!/bin/bash
# ip_for_gige.sh

# Set network interface up
echo "Set eth0 to 192.168.2.${AVEES_CLUSTERING_NODE_ID}5"
sudo ifconfig eth0 192.168.2.${AVEES_CLUSTERING_NODE_ID}5