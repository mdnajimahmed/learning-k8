- kubect get serviceaccount - *Each namespace has a default service account!*
- kubectl describe  serviceaccount default
- kubectl create serviceaccount my-first-service-account
- In Kubernetes 1.24, ServiceAccount token secrets are no longer automatically generated. https://stackoverflow.com/questions/72256006/service-account-secret-is-not-listed-how-to-fi
- kubectl create -f service-account-secret.yml 
- kubectl exec -it <PODNAME> ls /var/run/secrets/kubernetes.io/serviceaccount
- kubectl exec -it healthy-with-secret-6f4bd969f6-j5gqf ls /var/run/secrets/kubernetes.io/serviceaccount [*IT has to be a running pod*]
- kubectl exec -it healthy-with-secret-6f4bd969f6-j5gqf cat /var/run/secrets/kube
- THESE ARE DEPRECATED, here is the new way of doing - 
    - kubectl exec healthy-with-secret-6f4bd969f6-j5gqf -- cat /var/run/secrets/kubernetes.io/serviceaccount/token
    - kubectl exec healthy-with-secret-6f4bd969f6-j5gqf -- ls /var/run/secrets/kubernetes.io/serviceaccount
    - kubectl exec nginx-service-account-01 -- cat /var/run/secrets/kubernetes.io/serviceaccount/token
    - kubectl describe secret my-first-service-account-token | grep '^token' 
    <!-- - ** Not matching, could not use custom service account in a pod! :( ** -->
    - It works, take the token and use jwt.io and you will see the difference.