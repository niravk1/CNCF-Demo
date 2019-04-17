# Setup scripts
Use these scripts to prep and install an OL K8s cluster.

__NOTE:__ All scripts are based on setting up a K8s cluster based on Oracle Linux 7.6

## How to use the scripts.
Run the scripts in the following order.

1. ol-k8s-prep.sh
    - This can (and should) be run on all nodes that will be part of the cluster.
2. ol-k8s-master-setup.sh
3. ol-k8s-worker-setup.sh
