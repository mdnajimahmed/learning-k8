- kubectl get namespaces

kubectl get pods --namespace kube-public
No resources found in kube-public name

kubectl get pods --namespace kube-node-lease
No resources found in kube-node-lease namespace.

kubectl get pods --namespace kube-system
NAME                               READY   STATUS    RESTARTS        AGE
coredns-6d4b75cb6d-wkpwf           1/1     Running   1 (5h54m ago)   22h
etcd-minikube                      1/1     Running   1 (5h54m ago)   22h
kube-apiserver-minikube            1/1     Running   1 (5h54m ago)   22h
kube-controller-manager-minikube   1/1     Running   1 (5h54m ago)   22h
kube-proxy-d2r87                   1/1     Running   1 (5h54m ago)   22h
kube-scheduler-minikube            1/1     Running   1 (5h54m ago)   22h
storage-provisioner                1/1     Running   11              22h

- <servicename>.<namespace>.svc.<domainname> - <> means placeholder , for example db-service.dev.svc.cluster.local is a fully qualified service name which can be broken further into 
    - db-service : service name
    - dev: namespace
    - svc : indicates that it's a service
    - cluster.local: default kubernetes domain name.

- kubectl get pods --namespace=dev
- Namespace can be defined in the metadata section of the pod definition. 
```
kind: Pod
apiVersion: v1
metadata:
  name: my-first-pod
  **namespace: dev** ----------------------------------------> NAMESPACE specification
  labels:
    app: nginx
spec:
  containers:
    - name: nginx-app
      image: nginx
      resources:
        limits:
          cpu: 128m
          memory: 128Mi
      ports:
        - containerPort: 80
```
Alternatively we can mention it while creating a pod from a pod definition file like this - 
- kubectl create -f pod-definition.yaml --namespace=dev

# Creating a new namespace 
we can use a definition file, see the namespace.yml for example.
Alternatively we can use the following command - 
- kubectl create namespace dev

# VVI switching namespaces
- see the current context `kubectl config current-context`
- see the current default namespace `kubectl config view --minify | grep namespace`
- change the default namespace - 'kubectl config set-context --current --namespace=dev
- get pod from all namespaces `kubectl get pods --all-namespaces`

# Limit resources in a namespaces
It can be done by creating another k8s object called resource-quota. To see an example refer to resource-quota.yml file.

# delete namespace: 
- kubectl delete namespace dev