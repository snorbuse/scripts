#!/bin/bash

BASE_VM="arch-base"
KVM_USER="dread"
KVM_HOST="manhattan"

if [ -z $1 ]; then
    echo "You must provide a name:"
    echo "$0 <name>"
    exit -1;
fi

NEW_DOMAIN=$1

echo "Cloning disc $BASE_VM --> $NEW_DOMAIN"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system vol-clone --pool VolGroup01 $BASE_VM $NEW_DOMAIN

echo "Getting xml definition for $BASE_VM"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system dumpxml $BASE_VM > /tmp/$NEW_DOMAIN.xml

echo "Removing uuid from xml definition"
sed -i /uuid/g /tmp/$NEW_DOMAIN.xml 

echo "Removing (old) mac address from xml definition"
sed -i '/mac addr/d' /tmp/$NEW_DOMAIN.xml 

echo "Setting VM name to $NEW_DOMAIN in xml definition"
sed -i "s/$BASE_VM/$NEW_DOMAIN/" /tmp/$NEW_DOMAIN.xml 

echo "Defining new VM"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system define /tmp/$NEW_DOMAIN.xml

echo "Starting new VM"
virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system start $NEW_DOMAIN

