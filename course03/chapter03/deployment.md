- kubectl scale deployment nginx-deployment --replicas=4
- kubectl get deployment nginx-deployment -o yaml # now the replicas will be 4.
- kubectl rollout undo deployment/nginx-deployment
- kubectl rollout undo deployment/nginx-deployment --to-revision=2

# VVI: 
## How to do blue green deployment in k8s. (Lame)
- the current version has a label called version: v1, service uses this label to route traffice. When we deploy new version (v2) we use different label, version: v2, 
and use this label to update the service to route traffic from v1 to v2.
## How to do canary - ish? 
- Name each deployment by their version , e.g product-v1, product-v2 but they have a common label called service: product and use this label to create a service, then that service will route traffic to both the deployments.

# probes:
- Created a postgres pod with readiness probe, and exposed it via a service and verified the custom username password works. 

# Debug: 
 - kubeapi server log check: 
    - sudo cat /var/log/container/kube-apiserver-k8s-* search this folder, then go inside, take the latest log file.(ls -lt)
    - Example:
        - minikube ssh
        - cd /var/log/containers/
        - ls -lt | grep 'apiserver'
        - sudo cat /var/log/pods/kube-system_kube-apiserver-minikube_af8a252bb89a737e9c95199d01283487/kube-apiserver/15.log | grep error
    - Access kubelet logs - `sudo journalctl -u kubelet`