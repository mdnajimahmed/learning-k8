# now understood why common service deos not work, service is a lb for homogenous pods, my pods are heterogenous, so here is what happens
- service gets a request on spring port , service queries pods by tag, services chooses nginx pod and forward traffic to that pod as if it was a spring pod! 

- difference between cluster ip and nodeport
- # nginx-nodeport   NodePort    10.108.233.127   <none>        80:30011/TCP   6m15s
- service selector when updated, it appends with old tags! if selector tag is changed, better to do delete service and recreate!

# Ingress
- kubectl create ns 

# VVI: Pod reachability test
- kubectl -n <NAMESPACE> exec <PODNAME> -- curl podip
- `kubectl exec healthy-with-ingress-565b57d45c-d8svj -- curl http://localhost` - invoking curl::localhost in healthy pod
- `kubectl exec healthy-with-ingress-565b57d45c-d8svj -- curl http://172.17.0.5` - invoking curl::localhost in healthy pod
- if there is a dash in the spec.ingress.from:  that means or, otherwise it means and. - wow! VVI.
- if something is allowed by ingress, then the traffic will also go out using the same port(like security group stateless, unline NACL which is stateful)

# Network policy:
- get all network policy - `kubectl get networkpolicy`
- which pod is using a network selector?
    - kubectl get networkpolicy - will give (NAME,POD-SELECTOR,AGE) - get the label from pod selector column
    - `kubectl get pods --selector=app=ivplay4689_healthy` - assuming app=netpol appears in the previous query.
    - `kubectl get pod -l app=ivplay4689_healthy` - filter by label