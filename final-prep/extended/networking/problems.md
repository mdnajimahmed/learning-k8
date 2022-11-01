1. Allow ingress traffic for all the pods in ns-01923 for port range 32000-32768
```
    The endPort field must be equal to or greater than the port field.
    endPort can only be defined if port is also defined.
    Both ports must be numeric.
```
2. Create a namespace `ns014cd` and do this lab in this namespace. 
    - Only allow ingress from pods with label=tag=allowed from namespace `10oap3`
    - Only allow ingress from pods with label=tag=whitelisted from any namespace on port 80
    - only allow egress to google.com
    - Allow traffic to pods with label `tag: abc456` either pods from namespace `plq-2` with labels `check: itson` or pods with label `tag: pqr123`

# Solution
- kubectl create ns ns014cd   
- kubectl create ns 10oap3 `use tag - kubernetes.io/metadata.name=10oap3`
- kubectl create ns ak1-23
- kubectl create ns plq-2
- kubectl apply -f solution2.yml
- Test
    - Only allow ingress from pods with label=tag=allowed from namespace `10oap3`
        - setns ns014cd
        - kubectl get pods  -o wide
        - 10.244.205.198 is the ip of the nginx pod running in the ns014cd namespace.
        - setns 10oap3
        - kubectl run tester1 --image=busybox --restart=Never --labels=tag=allowed -- sleep 3600
        - kubectl run tester2 --image=busybox --restart=Never -- sleep 3600
        - kubectl exec tester1 -it -- wget -O- http://10.244.205.198 -T 2
        - kubectl exec tester2 -it -- wget -O- http://10.244.205.198 -T 2 `network unavailable because the label is not there`
        - setns 10oap3-shadow
        - setns default
        - kubectl run tester1 --image=busybox --restart=Never --labels=tag=allowed -- sleep 3600
        - kubectl exec tester1 -it -- wget -O- http://10.244.205.198 -T 2 `network unabailable becuase it's from a different namepsace, though it has the right label`
    - Only allow ingress from pods with label=tag:whitelisted from any namespace on port 80
        - kubectl exec tester2 -it -- wget -O- http://10.244.205.198 -T 2
        - setns default
        - kubectl run tester2 --image=busybox --restart=Never --labels=tag=whitelisted -- sleep 3600
        - kubectl exec tester2 -it -- wget -O- http://10.244.205.198 -T 2
        - Conflicts with the first rule above, does not work no matter which tag you use.
    - only allow egress to google.com
        - kubectl run tmp --image=busybox --restart=Never --rm -it -- wget -O- https://google.com
        - CAN NOT TEST, NEED TO OPEN 100 things.
    - Allow traffic to pods with label `tag: abc456` either pods from namespace `plq-2` with labels `check: itson` or pods with label `tag: pqr123`
        - kubectl label pod nginx tag=abc456
        - setns  plq-2
        - kubectl run tester1 --image=busybox --restart=Never --labels=check=itson -- sleep 3600
        - kubectl exec tester1 -it -- wget -O- http://10.244.205.198 -T 2 `works fine`
        - setns default
        - kubectl run tester3 --image=busybox --restart=Never --labels=tag=pqr123 -- sleep 3600 
        - kubectl exec tester3 -it -- wget -O- http://10.244.205.198 -T 2 `does not work`
        - Allow DNS query netpol.
        ```
        apiVersion: networking.k8s.io/v1
        kind: NetworkPolicy
        metadata:
        name: allow-allpods-to-dns
        spec:
        policyTypes:
        - Egress
        podSelector: {} 
        egress:
        - namespaceSelector:
            matchLabels:
                kubernetes.io/metadata.name: kube-system
            ports:
            - port: 53
            protocol: UDP
            - port: 53
            protocol: TCP
        ```