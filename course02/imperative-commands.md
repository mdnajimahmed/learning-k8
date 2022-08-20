# Instruction
Use imperative commands of k8s for this lab, no file. 

- deploy a pod named nginx-pod using the nginx:alpine image
    - kubectl run nginx-pod --image=ng
- deploy a pod named redis-pos using the redis image:alpine and label tier=db
    - kubectl run redis-prod --image=redis:alpine --labels=tier=db,app=practice
- create a service called redis-service to expose the redis pod in port 6379
    - kubectl expose pod redis-prod --name redis-service --port 679 --target-port=6379
- create a deployment with nginx image
    - kubectl create deployment nginx-deployment --image=nginx
    - kubectl scale deployment nginx-deployment replicas=3
- Create a custom nginx and expose it on port 8080
    - kubectl run custom-nginx image nginx --port=8080'
- Create a namespace called dev-ns
    - kubectl create ns dev-ns
- Deploy a pod in dev-ns
    - kubectl run dev-nginx --image=nginx --namespace=dev-ns
- Create a deployment in dev-ns namespace with a dry run yaml
    - kubectl create deployment nginx-in-dev-ns --image=nginx --namespace=dev-ns --dry-run=client -o yaml > nginx-in-dev-ns.yaml
- Create a servce of type Cluter id with httpd with target port = 80 
    - kubectl run httpd --image=httpd:alpine --port=80 --expose --dry-run=client -o yaml > cluster-ip-httpd.yaml
    - Note: ClusterIp is the default when we use  --expose, and it creates the service with the same name as pod. `kubectl describe service httpd | grep 'Type'` to verify
    