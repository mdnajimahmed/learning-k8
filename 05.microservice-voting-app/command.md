kubectl expose deployment voting-app --type=NodePort --name=voting-app-service

kubectl get services voting-app-service

minikube service --url voting-app-service

kubectl expose deployment result-app --type=NodePort --name=result-app-service

kubectl get services result-app-service

minikube service --url result-app-service
