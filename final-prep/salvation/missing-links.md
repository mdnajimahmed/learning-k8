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