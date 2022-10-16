- namespace , cgroup deep dive

- change user inside docker to run the docker process - `docker run --user=1000 ubuntu sleep 60`. We can also mention this user in the Dockerfile like 
```
USER 1000
```
- change capabilities of the docker user inside docker container - 
    - Add a Linux capability `docker run --cap-add MAC_ADMIN ubuntu`
    - Remove a Linux capability `docker run --cap-drop MAC_ADMIN ubuntu`
    - Add all linux capabilities `docker run --previlleged MAC_ADMIN ubuntu`

- We can define security context at a POD level or container level in pod.yml file. If we configure the security at the k8s pod level, then all the settings will be applied to all the container in the pod. 
- Settings on the container level will override the settings on the POD level.
- verify security context
    - minikube ssh
    - docker ps | grep 'sleep'
    - docker exec -it CONTAINER_ID bash