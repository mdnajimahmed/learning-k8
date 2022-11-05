# Namespace nonsense:
During exam we have to switch namespaces a lot.
- kubectl config view --minify | grep namespace
- kubectl config view | grep namespace
- kubectl config set-context --current --namespace=ggckad-s2

- vi ~/fn.sh
- source ~/fn.sh
```
getns(){kubectl config view | grep 'namespace'}
setns(){kubectl config set-context --current --namespace="$1"}
```
- do not use copy icon in mozila, do select and copy. mozilla copy icon sucks and adds more space.
- Port Scanning
    - nc -v -n -z -w 1 10.244.205.244 3306
        - v : verbose - shows message(success/error)
        - n : no dns lookup
        - z : makes nc not receive any data from the server
        - w : wait timeout
- it takes some time better to use `kubectl get ingress -w` vvi
- kubectl create svc clusterip myapp --tcp=80:80
- kubectl create svc nodeport test --tcp=80:3000 # creates a nodeport servcie with port=80, target port 3000, nodeport autoassigned, --node-port to explictely assign node port


# Updating things with command in (POD,DEPLOYMENT,JOB,CRONJOBS)
## POD update using command
- k run nginx-pod --image=nginx --env=PLAIN_ENV=plain_env
- k set `env,image,resources,serviceaccount`
- k create secret generic xsec --from-literal=user=najim --from-literal=password=pass@123
- k create cm xcm --from-literal=retrycount=3 --from-literal=show=bigbangtheory
- k set env pod nginx-pod --list
- k create deploy nginx --image=nginx
- kubectl set env deployment/nginx PLAIN_ENV=plain_env `Update deployment 'nginx' with a new environment variable` `rolls out new deployment`
    - k set env pod nginx-c7f6f4dc6-9m4dr  --list
- kubectl set env --from=configmap/xcm --prefix=MYSQL_ deploy nginx `# Import environment from a config map with a prefix`
    - k set env pod nginx-769947d446-rpwb4  --list
    - k exec nginx-769947d446-rpwb4  -it -- env | grep MYSQL
- kubectl set env --keys=show --from=configmap/xcm deployment/nginx `    # Import specific keys from a config map`
    - k exec nginx-5bc7fbdb86-4glxz   -it -- env | grep 'SHOW'
- kubectl set env deployments nginx --containers="nginx" PLAIN_ENV- MYSQL_RETRYCOUNT- MYSQL_SHOW- `# Remove the environment variable ENV from container 'c1' in all deployment configs`

# Summing up 
- k create deploy nginx --image=nginx
- k set env deploy nginx --from=secret/xsec --keys=password:MYTESTPASS
- k set env deploy nginx --from=configmap/xcm --keys=show
- k set env deploy nginx KEY=--from=secret/xsec/user --keys=user 
- DO NOT USE IT IF THERE IS A CUSTOM NAME NEEDED FOR ENV VARIABLE. USE IT FOR SIMPLE.