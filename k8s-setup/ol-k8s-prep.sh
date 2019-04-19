#!/bin/bash
# File:		ol-k8s-prep.sh
# Date:		16-APRIL-2019
# Author:	Uncle RedBeard (shawn.kelley@oracle.com)
# Desc:		update system for k8 deployment

# vars
YUM_CACHE=/var/cache/yum/

# functions (just cause i like clean scripts)
clean_yum () {
	printf "\nClean up yum cache...\n\n"

	sudo yum clean all
	sudo rm -rf $YUM_CACHE
	sudo yum makecache fast
}


docker_install () {
	printf "\nInstall docker-engine...\n\n"

	sudo yum-config-manager --enable ol7_addons
	sudo yum install -y docker-engine

	sudo systemctl enable docker
	sudo systemctl start docker
	sudo systemctl status docker
}

ntp_install () {
	printf "\nInstall ntpd...\n\n"

	sudo yum install -y ntp

	sudo systemctl enable ntpd
	sudo systemctl start ntpd
}

sec_stuff () {
	printf "\nCheck if firewalld is running...\n\n"
	sudo systemctl status firewalld

	printf "\nUpdate firewall rules...\n\n"
	sudo iptables -P FORWARD ACCEPT
	sudo iptables -L |grep FORWARD

	printf "\nSELinux setting...\n"
	sudo getenforce
}

#main
clean_yum
docker_install
ntp_install
sec_stuff

printf "done with prep...\n"

exit 0;
