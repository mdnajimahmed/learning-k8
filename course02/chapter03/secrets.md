- kubectl create secret generic <NAME_OF_THE_SECRET> --from-literal=<KEY>=<VALUE>
- kubectl create secret generic <NAME_OF_THE_SECRET> --from-file=<PATH-TO-FILE>
- kubectl create secret generic db-secret --from-file=db-secret.properties
- While creating secret using declaritive approach we must provide the secrets in hased format.
    - echo -n 'secret' | base64
    - echo -n c2VjcmV0 | base64 --decode
- secrets should be created without definition file, rather they should be created via command line
- `kubectl create secret generic course03-practice-secret --from-literal=DB_PASSWORD=postgres --dry-run=client -o yaml` - use this to create basic secret (key value) not manual; 
# VVI
How to extract the secret in k8s
- kubectl get secret healthy-app-secret -o yaml - output the yaml, it will give base64 encoded value of the secret
- then use base64 decoding. echo -n <SECRET> | 
- we can mount secret as a file-system.