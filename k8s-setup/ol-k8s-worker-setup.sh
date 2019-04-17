#!/bin/bash
# File:		ol-k8s-worker-setup.sh 
# Date:		16-APRIL-2019
# Author:	Uncle RedBeard (shawn.kelley@oracle.com)
# Desc:		Install required k8s binaries and setup k8s cluster

# functions
k8_worker_install () {
	printf "Install the K8s binaries...\n"

	sudo yum install -y kubeadm kubelet kubectl
}

k8_join () {
	printf "Join the K8 cluster...\n\n"

	# replace this with the output from ol-k8s-master-setup.sh
	#kubeadm-setup.sh join 10.0.2.82:6443 --token 5o7btf.kzxa2x9e4nybqcgf --discovery-token-ca-cert-hash sha256:bcbce60298bf43e35f573f9865a3cf3eb8e4057d4943c7f7adea9b529dd0e15b
}

# main
k8_worker_install
k8_join

exit 0;
