# Cluster setup for all other labs
- minikube start --nodes 2


# Cluster setup for network policy lab
- minikube start --network-plugin=cni --enable-default-cni
- cilium install
- https://anote.dev/install-minikube-with-cilium-cni-on-mac/
- kubectl -n kube-system get pods --watch
