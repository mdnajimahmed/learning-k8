# Using custom resource in k8s(CRD - Custom resource definition)
- We can create custom resource using CRD
- We can also create custom controller thats acts upon my custom resources in a specialized ways!(not part of the CKAD)

# Service account lab flow 
 - Create a service account (kind: ServiceAccount)
 - Create a pod with that service account (kind: Pod)
 - Give service account to access k8s pod api
    - Create role that has access to the pod api (kind: Role)
    - Bind the role with the service account (kind: RoleBinding)

# User vs Service account
- User usually authenticates using client certificate while SA uses tokens. Users are not represented by any k8s object. 
- Authorization happens using RBAC

# Admission Controller: (Basically an interceptor)
Admission controller intercept requests to the Kubernetes API after the authentication and authorization but before any objects are persisted. They can be used to validate,deny or event modify the request! 
- enable auto create namespace in the cluster
    - sudo vi sudo cat /etc/kubernetes/manifests/kube-apiserver.yaml 
    - --enable-admission-plugins=NamespaceAutoProvision (Add this separated by comma this this flag)
    - wait few seconds to kubeapiserver to be available again.

# Manage resources:
- Resource request: (kubernetes uses this info to decide which node suits best for the pod)
- Resource limit: (limit , max, hard upper limit), k8s will terminate the pod if it tries to go more than the limit(not for CPU, because CPU is throttled by OS anyway, it never exceeds, but if memory exceeds then the pod will be terminated.)

# ResourceQuota
- Kubernetes object to set limit on the resources within a namespace. If the creation or modification of the resource goes beyond the limit , then the request will be denied!
- need to enable resourceQuota in the admission controller.
- Prohibits creating new pod if new pod fails to be within the limit within a namespace.
- if there is a resource quota for a namespace then pods must have to define resource requests and limits - 
check the pod yaml config and then try to create the pod.
```
kubectl run nginx --image nginx -n=resource-quota-ns --dry-run=client -o yaml
```
```apple@Apples-MacBook-Pro chapter04 % kubectl run nginx --image nginx -n=resource-quota-ns                  
Error from server (Forbidden): pods "nginx" is forbidden: failed quota: resource-quota-test: must specify limits.cpu for: nginx; limits.memory for: nginx; requests.cpu for: nginx; requests.memory for: nginx
```
# Secrets and configmap
- Mount configmap as volume in a pod (cm-vol.yml)
- Mount configmap as env variable in a pod(cm-env.yml)
- Mount secret as volume in a pod (secret-vol.yml)
- Mount secret as env variable in a pod(secret-env.yml)

# Configurting Security Context for containers:
- what user to use to run the process inside container 
    - custom user id(uid)
    - custom group id (gid)
- privillege escalation mode
- make containers root file system read only.
    - runAsUser: 3000
    - runAsGroup: 4000
    - allowPrevillegeEscalation: false
    - readOnlyRootFileSystem: true
- we can define securityContext at POD level or at the container level.
- experiment readOnlyRootFileSystem: true , and then write using exec.
- `kubectl exec sec-ctx -- bash -c "echo 'Hello Najim' > /usr/share/nginx/html/index.html"` - I can write , but with readOnlyRootFilesystem: true we should not be. Lesson learned, with this flag, nginx can not start, because it needs to write something.
- VVI: `kubectl exec --stdin --tty configmap-demo-pod -- /bin/sh` - get bash of a running container.

# ConfigMap summary:
- Three ways we can make configMapAvailable to a pod
    1. Mount full configmap.
    ```
    envFrom:
      - secretRef:
          name: course03-practice-secret
      - configMapRef:
          name: course03-practice-cm
    ````
    2. Select a subset from the configmap
    ```
     env:
        # Define the environment variable
        - name: PLAYER_INITIAL_LIVES # Notice that the case is different here
                                     # from the key name in the ConfigMap.
          valueFrom:
            configMapKeyRef:
              name: game-demo           # The ConfigMap this value comes from.
              key: player_initial_lives # The key to fetch.
    ```
    3. Mount as a file:
    ```
    In the container 
    volumeMounts:
      - name: config
        mountPath: "/config"
        readOnly: true
    In the pod spec define the mapping 
    volumes:
    # You set volumes at the Pod level, then mount them into containers inside that Pod
    - name: config
      configMap:
        # Provide the name of the ConfigMap you want to mount.
        name: game-demo
        # An array of keys from the ConfigMap to create as files
        items:
        - key: "game.properties"
          path: "game.properties"
        - key: "user-interface.properties"
          path: "user-interface.properties"
    ```
    And then inside pod, cat /config/game.properties. If you omit the items array entirely, every key in the ConfigMap becomes a file with the same name as the key, and you get 4 files.

- Secrets are decoded when passed to pod as a file or env variable.
- Extract secret value from kubernetes
    - `kubectl get secret course03-practice-secret -o yaml ` - will show the secret in base64 , just get it from there and decode base64