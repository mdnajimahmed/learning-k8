# Content:
- https://codeburst.io/kubernetes-ckad-weekly-challenges-overview-and-tips-7282b36a2681

# Commands:
## Task 01:
- kubectl apply -f exercise01.yml --force 
- kubectl exec bash -- cat /tmp/hostname
- kubectl delete pod bash --force --grace-period 0
## Task 02:
- Create deployment with commnad - `kubectl create deploy nginx-deployment --image=nginx -o yaml --dry-run=client > nginx-deployment.yaml`
- Create pod with bash quickly `kubectl run -it testpod --image=busybox --restart=Never --rm`
- accessing service outside of namespace - curl http://nginx-service.k8n-challenge-2-a:4444 .
```
kubectl -n  k8s-challenge-2-a exec pod1 -- curl http://nginx-service:4444
<WORKS>

kubectl -n  k8s-challenge-2-b exec pod2 -- curl http://nginx-service:4444 
curl: (6) Couldn't resolve host 'nginx-service'
command terminated with exit code 6

kubectl -n  k8s-challenge-2-b exec pod2 -- curl  http://nginx-service.k8s-challenge-2-a:4444
<ALSO WORKS>

```

# Task 03: 
- Todo: Study PV, PVC, Job, Cron Job in details.
- Everything about job goes inside jobtemplate of a cron job (to be verified).

# Task 04:
- VVI Namepsace changing is very common
    - kubectl config set-context --current --namespace=one
    - kubectl config view --minify | grep namespace
    - kubectl create deployment my-deployment --image=nginx:1.14.2
    - kubectl scale deployment my-deployment --replicas=3
    - kubectl set image deployment my-deployment nginx=nginx:1.15.10 # deployments created by the command has the same container name and image name. We could also see the container name in the yaml outpout and use it this command.
    - kubectl rollout history deployment my-deployment
    - kubectl rollout undo deployment my-deployment

# Task 05:
- kubectl exec -it mypod -- cat /tmp/secret1/password
- kubectl create configmap drinks --from-file=drinks/ 

# Task 06:
- kubectl exec nginx-deployment-54c84d865-fq6kx -- nc -zv www.google.de 80
- kubectl exec nginx-deployment-54c84d865-fq6kx -- nc -zv api-service 3333
- kubectl exec api-deployment-645668c65c-pmbjp -- nc -zv www.google.de 80
- kubectl exec api-deployment-645668c65c-pmbjp -- nc -zv api-service 3333

# Task 07:
- kubectl create deployment compute --image=byrnedo/alpine-curl --dry-run=client -o yaml
- kubectl create service externalname webapi --external-name www.google.com --dry-run=client -o yaml
- kubectl exec compute-66c59cd477-wkwc5 -- ping webapi
- kubectl exec compute-66c59cd477-wkwc5 -- curl webapi --header "Host: www.google.com"
- kubectl exec compute-66c59cd477-wkwc5 -- curl webapi