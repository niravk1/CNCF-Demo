#!/bin/bash
# File:		ol-helm.sh
# Date:		16-APRIL-2019
# Author:	UncleRedBeard (shawn.kelley@oracle.com)
# Description:	Install Helm from Oracle YUM repos. 
# Credit:	This script is a modified version of https://github.com/jromers/k8s-ol-howto/tree/master/helm/helm-oracle.sh

# functions
install_helm () {

	printf "\nInstall Helm from Oracle YUM repo\n\n"
	
	# this *should* work, but sometimes there are issues with repos in your list
	#sudo yum-config-manager --enable ol7_developer

	# uncomment the following if you have trouble with the ol7_developer_UEK5 channel
	sudo yum-config-manager --save --setopt=ol7_developer_UEKR5.skip_if_unavailable=true
	sudo yum install -y helm

}

k8s_secret_svc () {

	# Replace with your Oracle SSO UserID
	user="shawn.kelley@oracle.com"

	if [ $# -gt 0 ]
	then
		user=$1
	fi

	printf "\nPassword for [%s]: " ${user:?}
	read -s pass

	printf "\n\nCreating K8s secret object for helm/tiller deployment...\n"

	kubectl create secret docker-registry ora-registry --namespace kube-system \
	--docker-server=container-registry.oracle.com \
	--docker-username="${user:?}" \
	--docker-password="${pass:?}" \
	--docker-email="${user:?}"

	printf "\nK8s secret created\n"

	printf "\nCreating k8s service-account...\n"

	kubectl create -f ora-registry.yaml

	printf "\nCreate a ClusterRoleBinding for tiller...\n"

	kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

}

helm_tiller_init () {

	printf "\nInitialize helm and tiller...\n"

	helm init --service-account tiller --tiller-image container-registry.oracle.com/kubernetes_developer/tiller:v2.9.1

	printf "\nDone! Now let's test our deployment...\n"

	helm version
	helm repo update
	helm search mysql

}

# main
install_helm
k8s_secret_svc
helm_tiller_init

exit 0;
