- kubectl create -f RS_FILE
- kubectl get replicaset
- kubectl delete rs NAME_OF_THE_REPLICASET
- kubectl replace -f RS_FILE

```
The difference between apply and replace is similar to the difference between apply and create.

create / replace uses the imperative approach, while apply uses the declarative approach.

If you used create to create the resource, then use replace to update it. If you used apply to
```
