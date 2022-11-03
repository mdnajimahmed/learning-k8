# Test 01:
- setns ns-a
```
kubectl get pod -o wide --show-labels
NAME                  READY   STATUS    RESTARTS   AGE   IP               NODE           NOMINATED NODE   READINESS GATES   LABELS
busybox-allowed-all   1/1     Running   0          91s   10.244.205.221   minikube-m02   <none>           <none>            tag=allowed-all
busybox-allowed-ns    1/1     Running   0          91s   10.244.205.220   minikube-m02   <none>           <none>            tag=allowed-ns
nginx                 1/1     Running   0          91s   10.244.205.213   minikube-m02   <none>           <none>            tag=target
```
- setns ns-b
```
kubectl get pod -o wide --show-labels
NAME                  READY   STATUS    RESTARTS   AGE   IP               NODE           NOMINATED NODE   READINESS GATES   LABELS
busybox-allowed-all   1/1     Running   0          60s   10.244.205.222   minikube-m02   <none>           <none>            tag=allowed-all
busybox-allowed-ns    1/1     Running   0          60s   10.244.205.215   minikube-m02   <none>           <none>            tag=allowed-ns
```
- from namespace b `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` works
- from namespace b `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` does not work
- from default namespace `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.213 -T 2` does not work either
- from namespace a `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` does not work because it does not match the namespace rule.
- from namespace a  `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` works because it has the allowed tag.

# Test 02:

- from namespace b `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` works
- from namespace b `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` does not work
- from default namespace `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.213 -T 2` does not work either
- from namespace a `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` does not work.
- from namespace a  `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` works .

# Test 03:

- from namespace b `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` does not work
- from namespace b `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` does not work
- from default namespace `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.213 -T 2` does not work either
- from namespace a `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.213 -T 2` does not work.
- from namespace a  `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.213 -T 2` works .

# Conclusion:
    - Documentation says 
    ```
    policy:

  ...
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          user: alice
    - podSelector:
        matchLabels:
          role: client
  ...

contains two elements in the from array, and allows connections from Pods in the local Namespace with the label role=client, or from any Pod in any namespace with the label user=alice
    ```
    But the experiment shows if we do not mention any namespace it only allows the default namespace.

# Attept 03, test 01:
- Target ip : `10.244.205.229`
- from ns-a `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.229 -T 2` works - `same namespace`
- from ns-b `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.229 -T 2` does not work.
- *More confirmation that when we don't mention any rule, it takes the self namespace*

# The clarification:
Behavior of to and from selectors (It's not network implementation driven)

There are four kinds of selectors that can be specified in an ingress from section or egress to section:

- podSelector: *This selects particular Pods in the same namespace as the NetworkPolicy* which should be allowed as ingress sources or egress destinations.

- namespaceSelector: This selects particular namespaces for which all Pods should be allowed as ingress sources or egress destinations.

- namespaceSelector and podSelector: A single to/from entry that specifies both namespaceSelector and podSelector selects particular Pods within particular namespaces. Be careful to use correct YAML syntax; this policy:

# Test (after modifying attempt2)
- setns ns-a
```
NAME                  READY   STATUS    RESTARTS   AGE    IP               NODE           NOMINATED NODE   READINESS GATES
busybox-allowed-all   1/1     Running   0          103s   10.244.205.233   minikube-m02   <none>           <none>
busybox-allowed-ns    1/1     Running   0          103s   10.244.205.226   minikube-m02   <none>           <none>
nginx                 1/1     Running   0          103s   10.244.205.227   minikube-m02   <none>           <none>
```
- setns ns-b
```
NAME                  READY   STATUS    RESTARTS   AGE    IP               NODE           NOMINATED NODE   READINESS GATES
busybox-allowed-all   1/1     Running   0          2m3s   10.244.205.225   minikube-m02   <none>           <none>
busybox-allowed-ns    1/1     Running   0          2m3s   10.244.205.232   minikube-m02   <none>           <none>
```
- from namespace b `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.227 -T 2` works
- from namespace b `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.227 -T 2` works
- from namespace b `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-other -- wget -O- 10.244.205.227 -T 2` does not work

- from default namespace `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-all -- wget -O- 10.244.205.227 -T 2`  works
- from default namespace `kubectl run tmp --image=busybox --rm -it --restart=Never --labels=tag=allowed-other -- wget -O- 10.244.205.227 -T 2` does not works

- from namespace a `kubectl exec busybox-allowed-ns -it -- wget -O- 10.244.205.227 -T 2` works.
- from namespace a  `kubectl exec busybox-allowed-all -it -- wget -O- 10.244.205.227 -T 2` also works.
