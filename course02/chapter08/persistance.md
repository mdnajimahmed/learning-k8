- we can create volume in the pod definition file, however it's not managable.
- thats why system admin creates persistence volume and developer claims those volumes by using persistanceVolumeClaim. 
- If the pod is deleted and there is a volume then we can still get the log given that the logs are actually written in the volume!
- StorageClass : Automates static provisioning of PV. Create a storage a class and from PVC , instead of pointing to PV point to a storage class using `storageClassName`
- StatefullSet Commands
    - kubectl get statefulset
    - kubectl scale statefulset <NAME> --replicas=3
- Stateful set creates pods in sequential order(one at a time) by default. Once the first pod is Ready and Running state, only then second pod is created. Pod name = stateful set name - 0,1,2,3 etc. For example mysql-0, musql-1 , given that mysql is the stateful set name. if mysql-0 pod dies, another pod with the same name mysql-0 will be created.
- stateful set use case - 
    - pods need stable name 
    - pods need to spin up in a certein order because pod spinned up later depends on pod spinned up former.
- *We must need to specify the name of a headless service under spec.serviceName*

# Headless service:
- normal/regular service distributes all traffic between all the pods, what about mysql read replica? mysql service can send a write request to a mysql read replica which is not expected. Solution is headless service. Headless service creates a DNS entry for each pod with their pod name, earlier we have seen, stateful set keeps pod name stable, and headless service creates dns with <stable-pod-name>.<HEADLESS SERVICE NAME>.<namespace>.svc.clsuter.local! POD ip can not be used because its ephemeral and keeps changing, pods dns can not be used because pods dns comes from ephimeral pod ips.

- When a headless service is created, the dns entries in the form of `<stable-pod-name>.<HEADLESS SERVICE NAME>.<namespace>.svc.clsuter.local` are created only two conditions are met - 
    - if there is a subdomain mentioned in the pod spec and that subdomain points to the headless service name.
    - hostname must be mentioned in the pod spec, hostname can be anything. (of course the kind should be StatefulSet)
    - * With stateful set we don't need to mention these two in the pod spec, we can mention the serviceName in the spec of the Stateful set and stateful set takes care of the rest. (creating the dns entries in the form of `<stable-pod-name>.<HEADLESS SERVICE NAME>.<namespace>.svc.clsuter.local`)
    - check `healthy-statefulset-0.healthy-headless-svc.default.svc.cluster.local` - verified
    - Dig result
    ```
    ; <<>> DiG 9.18.1-1ubuntu1.1-Ubuntu <<>> healthy-statefulset-0.healthy-headless-svc.default.svc.cluster.local
    ;; global options: +cmd
    ;; Got answer:
    ;; WARNING: .local is reserved for Multicast DNS
    ;; You are currently testing what happens when an mDNS query is leaked to DNS
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27840
    ;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
    ;; WARNING: recursion requested but not available

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ; COOKIE: 10d9aa1023377925 (echoed)
    ;; QUESTION SECTION:
    ;healthy-statefulset-0.healthy-headless-svc.default.svc.cluster.local. IN A

    ;; ANSWER SECTION:
    healthy-statefulset-0.healthy-headless-svc.default.svc.cluster.local. 30 IN A 10.244.120.92

    ;; Query time: 1 msec
    ;; SERVER: 10.96.0.10#53(10.96.0.10) (UDP)
    ;; WHEN: Tue Aug 30 05:16:39 UTC 2022
    ;; MSG SIZE  rcvd: 193

    Server:         10.96.0.10
    Address:        10.96.0.10#53
    ```
    - nslookup result
    ```
    Name:   healthy-statefulset-0.healthy-headless-svc.default.svc.cluster.local
    Address: 10.244.120.92
    ```