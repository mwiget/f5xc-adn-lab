```
mwiget@falk1:~/git/f5xc-adn-lab/consul$ kubectl get services -n mwadn
NAME          TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
consul-dev    ClusterIP   10.3.1.48    <none>        8500/TCP   2m32s
consul-pre    ClusterIP   10.3.1.49    <none>        8500/TCP   30s
consul-prod   ClusterIP   10.3.1.50    <none>        8500/TCP   17s
mwiget@falk1:~/git/f5xc-adn-lab/consul$ kubectl get pods -o wide -n mwadn
NAME                           READY   STATUS    RESTARTS   AGE     IP           NODE     NOMINATED NODE   READINESS GATES
consul-dev-54bd45f8df-w9hcj    2/2     Running   0          2m43s   10.1.2.178   ryzen2   <none>           <none>
consul-pre-794b4d76c7-kz5nh    2/2     Running   0          40s     10.1.2.179   ryzen2   <none>           <none>
consul-prod-66f86659cf-fn5sp   2/2     Running   0          28s     10.1.2.180   xeon1    <none>           <none>
```

