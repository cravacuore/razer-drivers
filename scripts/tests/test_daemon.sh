#!/bin/bash

#dependency : jq
#sudo apt-get install jq


# to retrieve an effect list
#sudo dbus-send --type=method_call --print-reply --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.fx.list

#first parameter is the effect uid
#returns the uid of the render node created as json


dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.fx.lib.load string:"daemon/fx/pez2001_mixer_debug.so"

#RUID=`dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:1 string:"First One Node" string:"a test node" | jq '.uid'`
RUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:1 string:"First One Node" string:"a test node"` )
RUID=${RUID[1]}
RUID2=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:2 string:"Breathing Node" string:"test node 2"` )
RUID2=${RUID2[1]}
RUID3=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:3 string:"Random Color Waves Node" string:"test node 3"` )
RUID3=${RUID3[1]}
#[ $? -eq 0 ] || echo "no daemon found";exit $?;
echo "setting render node uid : $RUID"


#set render node to compute/update by uid (deprecated)
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.set int32:$RUID

#connect the frame buffer to the render node by uid
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.frame_buffer.connect int32:$RUID


#set render node end counter parameter
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID/0 org.voyagerproject.razer.daemon.render_node.parameter.set int32:20
#set render node counter parameter
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID/1 org.voyagerproject.razer.daemon.render_node.parameter.set int32:0

#set render node dir parameter (increase step)
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID/2 org.voyagerproject.razer.daemon.render_node.parameter.set int32:4
#sleep 5
#set render node dir parameter (step back to normal)
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID/2 org.voyagerproject.razer.daemon.render_node.parameter.set int32:-1


#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID2 org.voyagerproject.razer.daemon.render_node.input.connect int32:$RUID3
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID org.voyagerproject.razer.daemon.render_node.input.connect int32:$RUID2

#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID org.voyagerproject.razer.daemon.render_node.opacity.set double:0.2
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID2 org.voyagerproject.razer.daemon.render_node.opacity.set double:0.8


#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID org.voyagerproject.razer.daemon.render_node.next.set int32:$RUID3
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID org.voyagerproject.razer.daemon.render_node.limit_render_time_ms.set int32:1000



TUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:12 string:"Transition Node" string:"transition test"` )
TUID=${TUID[1]}
MUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:13 string:"Mixer Node" string:"a mixer node"` )
MUID=${MUID[1]}
NUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:14 string:"Empty Node" string:"empty node for timing"` )
NUID=${NUID[1]}
WUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:15 string:"Wait for key Node" string:"use input for timing"` )
WUID=${WUID[1]}
RNDUID=( `dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_node.create int32:16 string:"Randomize Color Node" string:"randomize effect color"` )
RNDUID=${RNDUID[1]}

dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$RNDUID/0 org.voyagerproject.razer.daemon.render_node.parameter.set int32:5000
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$RNDUID/1 org.voyagerproject.razer.daemon.render_node.parameter.set int32:0
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$RNDUID org.voyagerproject.razer.daemon.render_node.next.set int32:$RNDUID
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID2 org.voyagerproject.razer.daemon.render_node.sub.add int32:$RNDUID


dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$MUID org.voyagerproject.razer.daemon.render_node.opacity.set double:1.0

dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$MUID org.voyagerproject.razer.daemon.render_node.input.connect int32:$RUID2
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$MUID org.voyagerproject.razer.daemon.render_node.second_input.connect int32:$RUID3




#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID3 org.voyagerproject.razer.daemon.render_node.next.set int32:$MUID

#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$RUID3 org.voyagerproject.razer.daemon.render_node.limit_render_time_ms.set int32:1000

dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$MUID org.voyagerproject.razer.daemon.render_node.sub.add int32:$WUID
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$NUID org.voyagerproject.razer.daemon.render_node.limit_render_time_ms.set int32:10000
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$NUID org.voyagerproject.razer.daemon.render_node.next.set int32:$WUID
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$WUID org.voyagerproject.razer.daemon.render_node.next.set int32:$TUID
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$TUID/0 org.voyagerproject.razer.daemon.render_node.parameter.set int32:1500
#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$TUID org.voyagerproject.razer.daemon.render_node.limit_render_time_ms.set int32:10000

#sudo dbus-send --type=method_call --dest=org.voyagerproject.razer.daemon /$TUID org.voyagerproject.razer.daemon.render_node.next.set int32:$NUID
dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon /$TUID org.voyagerproject.razer.daemon.render_node.next.set int32:$WUID

dbus-send --system --type=method_call --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.frame_buffer.connect int32:$MUID



dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon /$MUID org.voyagerproject.razer.daemon.render_node.subs.list


#RNS=`sudo dbus-send --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_nodes.list`
RNS=`dbus-send --system --type=method_call --print-reply=literal --dest=org.voyagerproject.razer.daemon / org.voyagerproject.razer.daemon.render_nodes.render_list`

#echo "list of render nodes available:\n$RNS"
echo "list of render nodes in rendering chain:\n$RNS"

