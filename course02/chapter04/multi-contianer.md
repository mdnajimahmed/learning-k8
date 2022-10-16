- multicontainer patterns
    - Ambassador :  Oursource db connectivity to another pod, the second pod contains logic for routing between dev,test or prod db while the main pod talks to the second pod. proxy!
    - Adpater
    - SideCar : main container sends logs to a sidecar container , sidecar container sends to central logging server

- from pod.yaml no change
- shares the same lifecycle , same network(localhost), storage

# Sidecar pattern
An extra container in your pod to enhance or extend the functionality of the main container. For example your existing pod deos not send log to splunk server, it logs to disk, so you need another container to collect the log from the disk and send it to the sidecar container.

# Ambassador pattern

A container that proxy the network connection to the main container. My APP will always talk to localhost:5432 to talk to db but there will be another container named pg-ambassador-{env} and that will route let the app connect to corresponding env specific db.

# Adapter pattern

A container that transform output of the main container. I have a container that exposes SOAP API but we have a new client expecting REST API. We can add another container that exposes REST API and internally calls the SOAP server. Now our POD will have soap api on port x and REST api on port y!

# Init Container:
In pod.yml file we can define a init container , like download the source code from the github in /work-dir path, then once this container exists main container will start and use the code downloaded in /work-dir path/