# Isolated vs Non Isolated pod:
- Any pod that is not selected by any network policy is an isolated pod. Open to all incoming and outgoing traffic(Network policy don't apply)
- If a pod is selected by at least one network policy its called non isolated pod. If a pod is selected by at least one network policy then it is only open to traffic that is explicitely allowed by a network policy that selects the pod. 
- There are two sorts of isolation for a pod: isolation for egress, and isolation for ingress. 
- By default, a pod is non-isolated for egress; all outbound connections are allowed. A pod is isolated for egress if there is any NetworkPolicy that both selects the pod and has "Egress" in its policyTypes; we say that such a policy applies to the pod for egress. When a pod is isolated for egress, the only allowed connections from the pod are those allowed by the egress list of some NetworkPolicy that applies to the pod for egress. The effects of those egress lists combine additively.

- By default, a pod is non-isolated for ingress; all inbound connections are allowed. A pod is isolated for ingress if there is any NetworkPolicy that both selects the pod and has "Ingress" in its policyTypes; we say that such a policy applies to the pod for ingress. When a pod is isolated for ingress, the only allowed connections into the pod are those from the pod's node and those allowed by the ingress list of some NetworkPolicy that applies to the pod for ingress. The effects of those ingress lists combine additively.

- Network policies do not conflict; they are additive. If any policy or policies apply to a given pod for a given direction, the connections allowed in that direction from that pod is the union of what the applicable policies allow. Thus, order of evaluation does not affect the policy result.

- For a connection from a source pod to a destination pod to be allowed, both the egress policy on the source pod and the ingress policy on the destination pod need to allow the connection. If either side does not allow the connection, it will not happen.



# Preparing minikube
- minikube start --network-plugin=cni --enable-default-cni
- https://anote.dev/install-minikube-with-cilium-cni-on-mac/
- kubectl -n kube-system get pods --watch

# Random node:
- somekey : {} means means any type in golang

# pod to pod connection test
- kubectl -n netpol-test-ns-b exec netpol-test-client -- curl -m 2 $(kubectl -n netpol-test-ns-a get pod netpol-test-server --template '{{.status.podIP}}')

# Test Net-Pol
- Verify default deny within a namespace. (verified)
- Enable pod - pod ingres from client to server without mentioning port(verify all port!) (verified)
- Mention a non 80 port in allow should block again. (verified)
- kubectl -n netpol-test-ns-a get pod -l app=netpol-test-server , kubectl -n netpol-test-ns-b get pod -l app=netpol-test-client 

```
kubectl -n netpol-test-ns-a describe netpol test-network-policy 
Name:         test-network-policy
Namespace:    netpol-test-ns-a
Created on:   2022-09-04 17:56:54 +0800 +08
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     app=netpol-test-server
  Allowing ingress traffic:
    To Port: 80/TCP
    From:
      PodSelector: app=netpol-test-client
  Not affecting egress traffic
  Policy Types: Ingress
```
# Service:
- A ClusterIp service exposes the application within the cluster network where it can be accessed by other pods. In this case the service client is internal.
- A NodePort service exposes the application externally by listening on an external port on each node. In this case service client is external.