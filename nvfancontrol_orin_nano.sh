#!/bin/bash
# nvfancontrol.sh

# Change fan-control strategy
cd ~/set_avees_clustering
sudo cp files/nvfancontrol_orin_nano.conf /etc/nvfancontrol.conf
sudo systemctl stop nvfancontrol
sudo rm /var/lib/nvfancontrol/status
sudo systemctl start nvfancontrol