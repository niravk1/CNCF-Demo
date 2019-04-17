#!/bin/bash
# File:		ol-k8s-master-install.sh
# Date:		16-APRIL-2019
# Author:	Uncle RedBeard (shawn.kelley@oracle.com)
# Desc:		install required k8s binaries and setup k8s cluster

# functions
k8s_install () {
	printf "\nInstalling the K8s binaries...\n\n"
	sudo yum install -y kubeadm kubelet kubectl

}

k8_cluster_setup () {

	# Replace with your Oracle SSO UserID
	user="shawn.kelley@oracle.com"

	if [ $#  -gt 0 ]
	then
		user=$1
	fi

	printf "\n\nPassword for [%s]: " ${user:?}
	read -s pass

	printf "\n\nLogin to container-registry.oracle.com...\n\n"
	docker login --username ${user:?} --password ${pass:?} container-registry.oracle.com

	printf "\n\nSetup the K8s cluster...\n"
	kubeadm-setup up

	printf "\n\nClean up the login...\n"
	docker logout container-registry.oracle.com
}

kubectl_user () {
	printf "Setup \'%s\' as a kubectl user...\n" $USER

	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config

	printf "\nQuick test...\n"
	kubectl get nodes
}

# main
k8_cluster_setup
kubectl_user

printf "Don't forget to capture the cluster join info after the setup is complete.\n"

exit 0;
