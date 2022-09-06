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