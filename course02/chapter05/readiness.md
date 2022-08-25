- POD status 
    - Pending	
        The Pod has been accepted by the Kubernetes cluster, but one or more of the containers has not been set up and made ready to run. This includes time a Pod spends 
        waiting to be scheduled as well as the time spent downloading container images over the network.
    - Running	The Pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting.
    - Succeeded	All containers in the Pod have terminated in success, and will not be restarted.
    - Failed	All containers in the Pod have terminated, and at least one container has terminated in failure. That is, the container either exited with non-zero status or was terminated by the system.
    - Unknown	For some reason the state of the Pod could not be obtained. This phase typically occurs due to an error in communicating with the node where the Pod should be running.

- Pending,ContainerCreating,Running,Terminated.
- Pod Conditions (complements pod status)
    - PodScheduled
    - Initialized
    - ContainersReady
    - Ready : The application is running and ready to take request, service routes request to a pod based on this condition.

- Readiness probe: 
    - Http Test: httpGet(path,port) , 
        - initialDelaySeconds: 10 (wait 10 seconds to boot up the app)
        - periodSeconds: 5 (send signals every 5 seconds.)
        - failureThreshold: default 3. after this the probe will stop.
    - TCP Test: tcpSocket(port)
    - Exec Command: exec -> command ["a","b"]