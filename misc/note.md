- `kubectl api-resources` - get the api documentation, could be handy.
- nc -z -v -w <TIMEOUT SECONDS> <SERVICE-NAME> <PORT>
- `kubectl get pods --selector=job-name=pi` -  get pods under a job
- Labeling commands are very handy 
    - kubectl label pod pod-calc id=calc
    - kubectl get pod --show-labels
- Works only with bash not zsh
    - export do="--dry-run=client -o yaml"
    - kubectl run pod1 --image=nginx $do
- kubectl run pod1 \
    -oyaml \
    --dry-run=client \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run deploy1 \
    -oyaml \
    --dry-run \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"

-   # .vimrc
    set tabstop=2
    set expandtab
    set shiftwidth=2
- # basic vim stuff
    Mark lines: Esc+V (then arrow keys)
    Copy marked lines: y
    Cut marked lines: d
    Past lines: p or P
- kubectl run job1 \
    -oyaml \
    --dry-run \
    --restart=OnFailure \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run cj1 \
    -oyaml \
    --dry-run \
    --schedule="* * * * *" \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run tmp --rm --image=busybox -it -- wget -O- google.com # restart=Never is important to make it work, see the next example
- kubectl run busybox --image=busybox  --restart=Never -it -- echo "How are you?"
- Useful JSONPATH Query
    - kubectl get pods -A -o jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\t"}{.status.podIP}{"\n"}{end}'

- Delete the pod you just created without any delay (force delete)
    - kubectl delete po nginx --grace-period=0 --force
- Change image inplace
    - kubectl run nginx --image nginx --port=80
- kubectl set image pod/nginx nginx=nginx:1.15-alpine
- kubectl get pod nginx -o jsonpath='{.spec.containers[].image} {.spec.containers[].image}{"\n"}'
- Get the IP Address of the pod you just created
    - kubectl get po nginx -o wide
- Create a busybox pod and run command ls while creating it and check the logs
    - kubectl run busybox --image=busybox --restart=Never -- ls
    - kubectl logs busybox
- If pod crashed check the previous logs of the pod
    - kubectl logs busybox -p
- kubectl run busybox --image=busybox --restart=Never -- /bin/sh -c "sleep 10"
- Create an nginx pod and list the pod with different levels of verbosity
    // create a pod
    kubectl run nginx --image=nginx --restart=Never --port=80
    // List the pod with different verbosity
    kubectl get po nginx --v=7
    kubectl get po nginx --v=8
    kubectl get po nginx --v=9

- List the nginx pod with custom columns POD_NAME and POD_STATUS
    - kubectl get po -o=custom-columns="POD_NAME:.metadata.name, POD_STATUS:.status.containerStatuses[].state"
- List all the pods sorted by *
    - kubectl get pods --sort-by=.metadata.name
    - kubectl get pods --sort-by=.metadata.creationTimestamp
- Get the pods with label env=dev [VVI]
    - kubectl get pods -l env=dev
- Get the pods with label env [VVI]
    - kubectl get pods -L env
- Get the pods with labels env=dev and env=prod [VVI]
    - kubectl get pods -l 'env in (dev,prod)'
- Change the label for one of the pod to env=uat and list all the pods to verify [VVI]
    - kubectl label pod/nginx-dev3 env=uat --overwrite
    - kubectl get pods --show-labels
- Remove the labels for the pods that we created now and verify all the labels are removed [VVI]
   - kubectl label pod nginx-dev{1..3} env-
   - kubectl label pod nginx-prod{1..2} env-
   - kubectl label pod d-dev-6cbbcc9d6f-{j7vkm,jpmgs} env-
- We can also label nodes!!!
    - kubectl get nodes --show-labels
    - kubectl label node minikube nodeName=nginxnode
- [VVI] Label a node and then deploy a pod in that node
    - minikube start --nodes 2
    - kubectl get nodes
    - kubectl label node minikube-m02 ec2=m4large
    - use the label in the nodeSelector in the pod spec.
- Annotate the pods with name=webapp
    - kubectl annotate pod nginx name=webapp
    - kubectl annotate pod nginx name=webapp2 --overwrite
    - kubectl annotate pod nginx name-
- Remove all the pods that we created so far
    - kubectl delete po --all
- Get the deployment rollout status
    - kubectl rollout status deploy webapp
- kubectl set image deploy/nginx nginx=nginx:1.17.4
- kubectl rollout undo deploy nginx
- kubectl describe deploy nginx | grep Image
- kubectl rollout status deploy nginx
- kubectl rollout history deploy nginx
- kubectl rollout undo deploy nginx --to-revision=3
- Get the pods of this deployment
- kubectl scale deploy webapp --replicas=20
- kubectl set image deployment webapp nginx=nginx:1.17.1 # creates a new revision.
- kubectl rollout history deployment webapp --revision=6
- [VVI] pause deployment, update image, resume deployment
    - kubectl rollout pause deploy webapp
    - kubectl set image deploy/webapp nginx=nginx:latest
    - kubectl rollout resume deploy webapp
- kubectl autoscale deploy webapp --min=1 --max=2 --cpu-percent=85  # deleted 1 pod because previously it was 2.
- kubectl get hpa
- kubectl get pod -l app=webapp
- kubectl create job node --image node -- node -v 
- [VVI] watch job completion
    - kubectl get job -w
    - 

- [VVI] study : kubernetes workloads in details(job, cron job etc)