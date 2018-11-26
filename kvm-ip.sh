#!/bin/bash

KVM_USER="dread"
KVM_HOST="manhattan"

function getIP() {
  host=$1
  mac=`virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system dumpxml $host | grep "mac address" |  tr -s \' ' '  |  awk ' { print $3 } '`
  #sudo nmap -sS 192.168.1.0/24 -p 22 > /dev/null 2>&1 
  ip=`arp -na | grep $mac | awk '{ print $2 }' | tr -d \( | tr -d \)`

  echo "$host: $ip"
}

function getHosts {
  virsh -c qemu+ssh://dread@manhattan/system list --name
}

function discoverAddresses {
  nmap -p 22 192.168.1.192/24 > /dev/null 2>&1
}

discoverAddresses
for H in `getHosts`; do
  getIP $H
done
