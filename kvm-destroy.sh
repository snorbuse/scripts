#!/bin/bash

KVM_USER="dread"
KVM_HOST="manhattan"

if [ -z $1 ]; then
    echo "You must provide a name:"
    echo "$0 <name>"
    exit -1;
fi

VM_NAME=$1

virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system destroy $VM_NAME

virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system vol-delete --pool VolGroup01 $VM_NAME

virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system undefine $VM_NAME
