- multicontainer patterns
    - Ambassador :  Oursource db connectivity to another pod, the second pod contains logic for routing between dev,test or prod db while the main pod talks to the second pod. proxy!
    - Adpater
    - SideCar : main container sends logs to a sidecar container , sidecar container sends to central logging server

- from pod.yaml no change
- shares the same lifecycle , same network(localhost), storage

# Sidecar pattern
An extra container in your pod to enhance or extend the functionality of the main container.

# Ambassador pattern

A container that proxy the network connection to the main container.

# Adapter pattern

A container that transform output of the main container.

# Init Container:
In pod.yml file we can define a init container , like download the source code from the github in /work-dir path, then once this container exists main container will start and use the code downloaded in /work-dir path/