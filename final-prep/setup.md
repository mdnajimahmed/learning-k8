# Cluster setup for all other labs
- minikube start --nodes 2


# Cluster setup for network policy lab
- minikube start --network-plugin=cni --enable-default-cni
- cilium install
- https://anote.dev/install-minikube-with-cilium-cni-on-mac/
- kubectl -n kube-system get pods --watch

# enable metrics:
- minikube addons list | grep metrics-server # Verify that 'metrics-server' addon is enabled:
- minikube addons enable metrics-server  # Enable metrics-server addon (if disabled):
- kubectl get pods --namespace kube-system | grep metrics-server # Verify that 'metrics-server' pod is running

# Trying with calico as per the official doc:
- minikube delete --all 
- minikube start --nodes 2 --network-plugin=cni --cni calico `https://projectcalico.docs.tigera.io/getting-started/kubernetes/minikube`
- kubectl get pods -l k8s-app=calico-node -o wide -A -w `make sure they are in running state and there is no abnormality in restart count`



# All together:
- minikube delete --all 
- minikube start --nodes 2 --network-plugin=cni --cni calico `https://projectcalico.docs.tigera.io/getting-started/kubernetes/minikube`
- kubectl get pods -l k8s-app=calico-node -o wide -A -w `make sure they are in running state and there is no abnormality in restart count`

- minikube addons list | grep metrics-server # Verify that 'metrics-server' addon is enabled:
- minikube addons enable metrics-server  # Enable metrics-server addon (if disabled):
- kubectl get pods --namespace kube-system | grep metrics-server # Verify that 'metrics-server' pod is running

- minikube addons enable ingress