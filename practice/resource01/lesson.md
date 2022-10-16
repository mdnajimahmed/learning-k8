- ResourceQuota
    - kubectl -n mynamespace get resourcequota
    - kubectl -n mynamespace create quota myrq --hard=cpu=1,memory=1G,pods=2 
- Most of the tutorials are suggesting --restart=Never with kubectl run! let's start using it in practice.
- change image of a running pod seems to have challenge, need to practice
    - kubectl set image POD/POD_NAME CONTAINER_NAME=IMAGE_NAME:TAG
    - kubectl run busybox --image=busybox --rm -it --restart=Never -- wget -O- 10.1.1.131:80 # should be capital '-O-'
    - kubectl run bb1 --image=busybox --rm -it --restart=Never -- echo 'Hello world' # -it is important. # --rm ensures that the pod is deleted, so no log!
    - Create an nginx pod and set an env value as 'var1=val1'. Check the env value existence within the pod
        - kubectl run nginx --image=nginx --env=var1=val1
- kubectl run mpbb --image=busybox --restart=Never --dry-run=client -o yaml  -- /bin/sh -c "echo hello; sleep 3600" > task02.yml # if you need multiline command go with /bin/sh -c 'MULTI_LINE_SEPARATED_MY_SEMICOLON'
- run tmp --image=busybox --rm --restart=Never -it -- /bin/sh -c 'wget -O- 172.17.0.9'
- for i in `seq 1 3`; do echo i=$i ; done; # `` - symbol is mandatory
- for i in `seq 1 3` ; do kubectl run nginx$i --image=nginx --labels=app=v1; done; # labels not label!!!
- kubectl delete pod -l app=v1 # delete by label.
- kubectl get pods -L app 
- kubectl get pods -l app=v1 --show-labels  # search by labels
- kubectl get pods --selector=app=v1
- Update label:
    - update label : kubectl label pod nginx2 app=v2 --overwrite
    - update label using -l 'app in (v1,v2)' !: kubectl label pod -l 'app in (v1,v2)' tier=web --overwrite
    - update label using selector !: kubectl label pod -l 'app in (v1,v2)' tier=web --overwrite # user this , this is intutive
    - kubectl label pod --selector='app in (v1,v2)' type=test --overwrite
    - find pods having a certein label : kubectl get pod --selector=app
- Add a new label tier=web to all pods having 'app=v2' or 'app=v1' labels
- Annotation
    - kubectl annotate pod --selector='app=v2' owner=marketing
    - kubectl get pod --selector='app=v2' -o yaml | grep -i 'annotations' -A 3
    - be careful, its not `owner:marketing`, its  owner=marketing
    - we can use -l and (= or in query as the last example)
- Remove label:
    - kubectl label pod --selector=app app-
    - kubectl label po -l app app-
- Annotations
    - kubectl annotate po nginx1 nginx2 nginx3 description='my description'
    - kubectl annotate po nginx{1..3} description='my description'
    - for i in `seq 1 3`; do kubectl annotate pod nginx$i description='my description'; done
    - VVI : get the annotations with a specific pod 
        - kubectl annotate pod nginx1 --list
        - kubectl annotate pod -l tier --list # multiple
        - kubectl annotate po nginx{1..3} description- # delete annoations.
- VVI : Practice labeling and annotating CRUD much more. seeming a bit shaky!
    - kubectl annotate pods nginx{1..3} description-
    - kubectl annotate pod nginx{1..3} --list
- kubectl create deployment dnginx --image=nginx:1.18.0 --replicas=2 --port=80 --dry-run=client -o yaml > task05.yml
- kubectl label pods dnginx-69478b4459-{gll89,tg7zn} tier=web # manually labeling pods under a deployment
- Labeling a deployment does not automatically label the pods.
- kubectl set image deployment dnginx nginx=nginx:1.19.8 , resource01 % kubectl get rs to check if new deployment is created and working, kubectl get rs dnginx-69478b4459 -o yaml | grep -i 'image'
- kubectl set image deploy dnginx nginx=nginx:1.2.3 , kubectl get rs, kubectl rollout status deploy dnginx
- kubectl rollout undo deploy dnginx --to-revision=2 # VVI, it's not --revision, it --to-revision, and yes it's the undo operation.
- VVI : 
    - Check the details of the fourth revision (number 4): kubectl rollout history deploy nginx --revision=4
- kubectl autoscale deploy dnginx --min=2 --max=5 --cpu-percent=80
- kubectl rollout pause deploy dnginx
- VVI (failed)
    - Implement canary deployment by running two instances of nginx marked as version=v1 and version=v2 so that the load is balanced at 75%-25% ratio
    - create first deployment with *pod* tag version=v1 and app=webapp. create 3 replicas of this deployment.
    - create first deployment with *pod* tag version=v2 and app=webapp. create 1 replicas of this deployment.
    - create service for label app=webapp.
    - then scale up v2 to 4 and *shut down* v1.
- VVI : wow i did not know that you can get log of jobs
    - kubectl logs job/busybox
- kubectl create cm cm1 --from-literal=foo=lala --from-literal=foo2=lolo
- kubectl create cm cm2 --from-env-file=config.tx
- Create and display a configmap from a file, giving the key 'special'. Create the file with
    - echo -e "var3=val3\nvar4=val4" > config4.txt
    - kubectl create cm configmap4 --from-file=special=config4.txt
    - kubectl describe cm configmap4
    - kubectl get cm configmap4 -o yaml
- kubectl exec -it ngcm -- /bin/sh -c "env | grep -i option" # check if the env variable is mounted properly
- kubectl get secret mysecret2 -o jsonpath='{.data.username}' | base64 -d
- Lots of pods are running in qa,alan,test,production namespaces. All of these pods are configured with liveness probe. Please list all pods whose liveness probe are failed
    - kubectl get events -o json | grep 'message'
- VVI: kubectl get events | grep -i error # you'll see the error here as well
- VVI: kubectl run nginx --image=nginx --restart=Never --port=80 --expose # remind the --expose flag
```
kubectl run nginx --image=nginx --restart=Never --port=80 --expose
*** service/nginx created *** 
*** pod/nginx created *** 
```
- VVI: kubectl expose deploy 
- VVI : 
    - Create an nginx deployment of 2 replicas, expose it via a ClusterIP service on port 80. Create a NetworkPolicy so that only pods with labels 'access: granted' can access the deployment and apply it
    ```
    kind: NetworkPolicy
    apiVersion: networking.k8s.io/v1
    metadata:
    name: access-nginx # pick a name
    spec:
    podSelector:
        matchLabels:
        app: nginx # selector for the pods
    ingress: # allow ingress traffic
    - from:
        - podSelector: # from pods
            matchLabels: # with this label
            access: granted
    ```
    - Testing: 
        - kubectl run busybox --image=busybox --rm -it --restart=Never -- wget -O- http://nginx:80 --timeout 2   # This should not work. --timeout is optional here. But it helps to get answer more quickly (in seconds vs minutes)
        - kubectl run busybox --image=busybox --rm -it --restart=Never *--labels=access=granted* -- wget -O- http://nginx:80 --timeout 2  # This should be fine
- VVI: 
    - Create a busybox pod with 'sleep 3600' as arguments. Copy '/etc/passwd' from the pod to your local folder
    - kubectl run busybox --image=busybox --restart=Never -- sleep 3600
    - kubectl cp busybox:/etc/passwd ./passwd # kubectl cp command
    - kubectl delete pod nginx --grace-period=0 --force # Deleting Kubernetes objects quickly

- VVI 
    - Finding specific annotations
        - Print the sourrounding 10 lines of Pod description for any existing Pod with the annotation author=John Doe.
        - kubectl describe pods | grep -C 10 "author=John Doe"

    - Finding all labels
        - Print labels for all Pods and determine their Pod names. Render the output in YAML format.
        - kubectl get pods -o yaml | grep -C 5 labels: