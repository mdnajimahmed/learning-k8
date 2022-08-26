# Labels and selectors:
- definition file -> metadata -> labels -> key-value pair
- select pod by labels = `kubectl get pods --selector app=App1`
- like labels, we can also define annotations under metadata. not queryabe and should be preserved while modifying objects. 


# Roullout :
- kubectl rollout status deployment deployment-name
- kubectl rollout history deployment deployment-name

# Deployment strategies:
- kill all pods and run new pods (RecreateStrategy). - has downtime
- RollingUpdate(take one down, and do one up, until all pods are updated) - default
- kubectl apply -f <FILENAME>
- kubect set image <DEPLOYMENT-NAME> --image=nginx:newVersion
- kubectl describe deployment to see details of a deployment.
- A new deployment with rolling update creates a *NEW* replicaset. Takes down one pod from the old replicaset and spins up one new pod in the new replicast. can be verified looking at `kubectl get replicaset`.
- Rollabck : kubectl rollout undo <DeploymentName>
- record the deployment history : `kubectl create -f deployment.yml --record`
- kubectl create -f healthy-deployment.yml --record
- interesting thing happened, at first my memory allocaion was 256Mi, but pods were crushing, from log , I understood that it's resource limit that is stopiping containers rom running. So i increased memory and all pod started