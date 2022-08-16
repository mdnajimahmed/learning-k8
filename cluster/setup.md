kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

kubeadm init --apiserver-advertise-address=192.168.56.2 --ignore-preflight-errors all --pod-network-cidr=10.244.0.0/16 --token-ttl 0

kubeadm init --pod-network-cidr=10.5.0.0/16 --apiserver-advertise-address= $(hostname -i)

kubeadm init --apiserver-advertise-address=192.168.56.2 --ignore-preflight-errors all --pod-network-cidr=10.244.0.0/16 --token-ttl 0

kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
