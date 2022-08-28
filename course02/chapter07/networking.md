# now understood why common service deos not work, service is a lb for homogenous pods, my pods are heterogenous, so here is what happens
- service gets a request on spring port , service queries pods by tag, services chooses nginx pod and forward traffic to that pod as if it was a spring pod! 

- difference between cluster ip and nodeport
- # nginx-nodeport   NodePort    10.108.233.127   <none>        80:30011/TCP   6m15s
- service selector when updated, it appends with old tags! if selector tag is changed, better to do delete service and recreate!

# Ingress
- kubectl create ns ingress-space