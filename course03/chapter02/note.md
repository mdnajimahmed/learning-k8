# save an image file
- docker save -o /home/docker_back/my_site_0.0.1 tar.<NAME>:<TAG1>
- init container runs once before init contianer. Use case
    - add delay
    - install prequires softwares, download prerequisit files, do some initial configuration.
    - comsuming secrets, we can have a init contianer with aws access to download secret and dump it somewhere.

# Persistance
- Volume -> (declared in the pod)
- PersistanceVolume -> (kuberneters object)
- PersistanceVolumeClaim -> (kuberneters object)
- StorageClass -> (kuberneters object)

# VolumeType:
### emptyDir:
```
    volumeMounts:
      - name: shared-folder
        mountPath: /input
  volumes:
    - name: shared-folder
      emptyDir: {}
```


### hostpath: (hostpath type decides based on File, FileOrCreate, Directory, DirectoryOrCreate - only for hostPath)
    - emptyDir: {} - ephemeral.
    ```
        volumeMounts:
      - name: my-vol-01
        mountPath: /vol-path
    volumes:
        - name: my-vol-01
          hostPath:
            path: /testdir
            type: Directory
    ```

# persistance volume:
- abstract away the volume creation and treats volume just as a consumeable resource. basically move out volume definition from pod.
- pod -> pvc -> pv
- PVC - PV matching criteria - 
    - A PersistentVolumeClaim (PVC) is a request for storage by a user. It is similar to a Pod. Pods consume node resources and PVCs consume PV resources. 
    - The control plane still checks that storage class, access modes, and requested storage size are valid.
- When you create a PVC , you dont know with which PV it will bind it. But there are ways we can control this, `volumeName` is one such thing. 
- pvc is found but still the actual volume on disk is not created!
- verified: only when pod is created and the PVC is created by the pod, the actual directory was created.