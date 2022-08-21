kubectl describe pods my-first-deployment-68d8c49648-2j5c9
app=nginx
pod-template-hash=68d8c49648

kubectl describe rs my-first-deployment-68d8c49648
app=nginx
pod-template-hash=68d8c49648

# VVI : 
Replicaset created by deployments does not interfare with other pods as the same label as the deployment template label. Because, the deployment creates a new label called `pod-template-hash` which is added in the replicaset created by the deployment and later used in pod creation!
- kubectl describe deployments my-first-deployment | grep 'Image'
- `kubectl scale deployment my-first-deployment --replicas=6` - Scale deployment
- `kubectl replace -f course02/deployment.yml` - take deployment back to original file!