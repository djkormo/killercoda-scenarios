Backup cluster k8s

Backup etcd to file /opt/etcd-backup.db


`kubectl get pods -n kube-system`{{execute}}


`kubectl get pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe  pods -n kube-system -l component=etcd |grep Command: -A18`{{execute}}

`etcdctl`{{execute}}
<pre>
Command 'etcdctl' not found, but can be installed with:

snap install etcd         # version 3.4.5, or
apt  install etcd-client

See 'snap info etcd' for additional versions.
</pre>

If etcdctl is not found we have to install it.

`apt-get install etcd-client -y`{{execute}}

Only 3.x version and 3.x API version should be used.

`etcdctl version`{{execute}}

<pre>
etcdctl version: 3.5.1
API version: 3.5
</pre>

To use API 3.x set ETCDCTL_API variable

`export ETCDCTL_API=3`{{execute}}
`etcdctl version`{{execute}}
<pre>
etcdctl version: 3.5.1
API version: 3.5
</pre>


Hint!

use command in such a way

`ETCDCTL_API=3 etcdctl \
  --endpoints=https://[127.0.0.1]:2379 \
  --cacert=...ca.crt \
  --cert=...server.crt \
  --key=...server.key \
  snapshot save filename
  `{{copy}}

After running proper command you should see something like this:

<pre>
{"level":"info","ts":1654461278.1012843,"caller":"snapshot/v3_snapshot.go:68","msg":"created temporary db file","path":"/opt/etcd-backup.db.part"}
{"level":"info","ts":1654461278.1084728,"logger":"client","caller":"v3/maintenance.go:211","msg":"opened snapshot stream; downloading"}
{"level":"info","ts":1654461278.108607,"caller":"snapshot/v3_snapshot.go:76","msg":"fetching snapshot","endpoint":"https://[127.0.0.1]:2379"}
{"level":"info","ts":1654461278.1743407,"logger":"client","caller":"v3/maintenance.go:219","msg":"completed snapshot read; closing"}
{"level":"info","ts":1654461278.179867,"caller":"snapshot/v3_snapshot.go:91","msg":"fetched snapshot","endpoint":"https://[127.0.0.1]:2379","size":"5.8 MB","took":"now"}
{"level":"info","ts":1654461278.1799042,"caller":"snapshot/v3_snapshot.go:100","msg":"saved","path":"/opt/etcd-backup.db"}
Snapshot saved at /opt/etcd-backup.db
</pre>


**Remember the objects in default namespace**

`kubectl get all -n default`{{execute}}

<pre>

NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-6b474476c4-68shl   1/1     Running   0          7m2s
pod/my-nginx-6b474476c4-khvs9   1/1     Running   0          7m2s
pod/my-nginx-6b474476c4-r8x6n   1/1     Running   0          7m2s

NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes     ClusterIP      10.96.0.1      <none>        443/TCP        12m
service/my-nginx-svc   LoadBalancer   10.101.83.14   <pending>     80:31662/TCP   12m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-nginx   3/3     3            3           12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-6b474476c4   3         3         3       12m
controlplane $ kubectl get all,ep -n default
NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-6b474476c4-68shl   1/1     Running   0          7m20s
pod/my-nginx-6b474476c4-khvs9   1/1     Running   0          7m20s
pod/my-nginx-6b474476c4-r8x6n   1/1     Running   0          7m20s

NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes     ClusterIP      10.96.0.1      <none>        443/TCP        12m
service/my-nginx-svc   LoadBalancer   10.101.83.14   <pending>     80:31662/TCP   12m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-nginx   3/3     3            3           12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-6b474476c4   3         3         3       12m

NAME                     ENDPOINTS                             AGE
endpoints/kubernetes     172.17.0.65:6443                      12m
endpoints/my-nginx-svc   10.5.1.6:80,10.5.1.7:80,10.5.1.8:80   12m

</pre>


Checking status of backup

ETCDCTL_API=3 ... snapshot status-w table /opt/etcd-backup.db
<pre>
+----------+----------+------------+------------+
|   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE |
+----------+----------+------------+------------+
| 66b8edae |     2325 |       2339 |     3.9 MB |
+----------+----------+------------+------------+
</pre>


CHECK

`[ -f /opt/etcd-backup.db ] && [ -f /opt/etcd-backup.db ] && echo "done"`{{execute}}

CHECK

To continue you have to backup etcd to /opt/etcd-backup.db file

**To move to the next step make sure to have all checks with "done"**


Literature:

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster






