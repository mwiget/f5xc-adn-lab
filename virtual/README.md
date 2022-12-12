
```
helm repo add hashicorp https://helm.releases.hashicorp.com
export KUBECONFIG=kubeconfig-dev.yaml
helm install --values helm/values-v1.yaml consul hashicorp/consul --create-namespace --namespace consul --version "1.0.0"
```



```
$ kubectl get services
NAME          TYPE        CLUSTER-IP        EXTERNAL-IP   PORT(S)    AGE
consul-http   ClusterIP   192.168.156.155   <none>        8500/TCP   5h20m
consul-rpc    ClusterIP   192.168.121.231   <none>        8400/TCP   5h20m
mwiget@falk1:~/git/f5xc-adn-lab/virtual$ kubectl get services -o wide
NAME          TYPE        CLUSTER-IP        EXTERNAL-IP   PORT(S)    AGE     SELECTOR
consul-http   ClusterIP   192.168.156.155   <none>        8500/TCP   5h20m   app=consul
consul-rpc    ClusterIP   192.168.121.231   <none>        8400/TCP   5h20m   app=consul
mwiget@falk1:~/git/f5xc-adn-lab/virtual$ kubectl get deployments -o wide
NAME     READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS   IMAGES   SELECTOR
consul   1/1     1            1           5h21m   consul       consul   app=consul
mwiget@falk1:~/git/f5xc-adn-lab/virtual$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE     IP          NODE              NOMINATED NODE   READINESS GATES
consul-5dbbbc586c-2khxb   2/2     Running   0          5h10m   10.1.0.23   marcel-zg01-igw   <none>           <none>
```

