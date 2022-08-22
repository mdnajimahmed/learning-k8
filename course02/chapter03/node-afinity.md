- Affinity types :- 
    - requiredDuringSchedulingIgnoredDuringExecution
    - preferredDuringSchedulingIgnoredDuringExecution
- May be in future requiredDuringSchedulingRequiredDuringExecution

- Common operators 
    - In
    - NotIn
    - Exists [values section not required]

- If no node found with the expression defined in the pod, the pod will not be scheduled because we selected `**required**DuringSchedulingIgnoredDuringExecution`
# Lab: 
- Find number of labels on a node - 
    - kubectl describe node minikube-m03 | grep -i labels -A5 
    - kubectl get node minikube-m03 --show-labels 
- set a new label 
    - kubectl label node minikube-m03 color=blue