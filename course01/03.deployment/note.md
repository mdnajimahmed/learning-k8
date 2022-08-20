- kubectl create -f RS_FILE --record
- kubectl get deployment
- kubectl describe deployment my-first-deployment
- kubectl get rs
- kubectl describe rs my-first-deployment-6854ccc9bf
- kubectl get all
- kubectl get all -A
# Deployment/Rollout status

- kubectl rollout status deployment my-first-deployment
- kubectl rollout history deployment my-first-deployment
- kubectl replace -f my-first-deployment.yml
- kubectl describe deployment my-first-deployment

# Rollback

- kubectl rollout undo deployment my-first-deployment
