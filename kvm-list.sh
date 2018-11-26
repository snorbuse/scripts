#!/bin/bash

KVM_USER="dread"
KVM_HOST="manhattan"

virsh -c qemu+ssh://$KVM_USER@$KVM_HOST/system list --all
