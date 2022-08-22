# VVI : 
- by default K8s assigns CPU = 500m, Memory = 250Mb 
- if cpu goes higher its throttled by OS/CPU , if it goes over memory, the POD is restarted!!!
- kubectl run check-resource --image=nginx