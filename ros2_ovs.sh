#!/bin/bash
# ros2_ovs.sh

# Make xml file
echo "<?xml version="1.0" encoding="UTF-8" ?>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "<dds xmlns="http://www.eprosima.com/XMLSchemas/fastRTPS_Profiles">" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t<profiles>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t<transport_descriptors>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t<transport_descriptor>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t<transport_id>CustomUdpTransport</transport_id>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t<type>UDPv4</type>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t<interfaceWhiteList>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t\t<address>192.168.2.${AVEES_CLUSTERING_NODE_ID}0</address>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t\t<address>192.168.2.255</address>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t</interfaceWhiteList>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t</transport_descriptor>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t</transport_descriptors>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\n\t\t<participant profile_name="CustomTcpTransportParticipant" is_default_profile="true">" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t<rtps>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t<userTransports>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t\t<transport_id>CustomUdpTransport</transport_id>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t</userTransports>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t\t<useBuiltinTransports>false</useBuiltinTransports>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t\t</rtps>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t\t</participant>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "\t</profiles>" >> ~/set_avees_clustering/files/interface_profile.xml
echo "</dds>" >> ~/set_avees_clustering/files/interface_profile.xml

# Set Alias in ~/.bashrc
echo "\n# Set Ros2 communication on specific ethernet" >> ~/.bashrc
echo "export FASTRTPS_DEFAULT_PROFILES_FILE=/home/avees/set_avees_clustering/files/interface_profile.xml" >> ~/.bashrc