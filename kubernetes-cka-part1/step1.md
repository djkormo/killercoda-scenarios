**Step 0**

Upgrade cluster from version 1.22.x to 1.23.y

Show list of cluster nodes

`kubectl get nodes`{{execute}}

Here we have cluster with 1.22 version

List all of objects in default namespace

`kubectl get all -o wide`{{execute}}

Out goal is to have running 1.23.x version cluster.

`kubectl version --short &&
kubeadm version -o short &&
kubelet --version
`{{execute}}

Update packages

`apt-get update`{{execute}}

Install specific version of  kubeadm, kubelet and kubectl

`apt-get install kubeadm=1.23.6-00 kubectl=1.23.6-00 kubelet=1.23.6-00 -y`{{execute}}

If some of the packages is hold add '--allow-change-held-packages'

`apt-get install kubeadm=1.23.6-00 kubectl=1.23.6-00 kubelet=1.23.6-00 -y --allow-change-held-packages`{{execute}}

What upgrade plan is possible ?

`kubeadm upgrade plan`{{execute}}

Let's upgrade (remember to confirm by pressing y key) 

`kubeadm upgrade apply v1.23.6`{{execute}}

In case of trouble with kubelet configuration (node controleplane is notReady)

`cat /var/lib/kubelet/kubeadm-flags.env`{{execute}}

Remove --network-plugin=cni according to issue

https://github.com/kubernetes/website/issues/33640

Let's see the cluster nodes

`kubectl get nodes`{{execute}}

Now we have master node with 1.23 version and worker node with 1.22

**Look what deployment and pods are on our cluster. Preserve them**


The first thing is to detach worker node01 from kubernetes cluster.

`kubectl drain node01`{{execute}}

<pre>
node/node01 cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): alone/alone-pod, alone/web-server
cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-system/calico-node-pdjlj, kube-system/kube-proxy-kqlkj
</pre>

List all pods running on node01

`kubectl describe node node01 |grep Non-terminated -A 8`{{execute}}

<pre>
Non-terminated Pods:          (8 in total)
  Namespace                   Name                         CPU Requests  CPU Limits  Memory Requests  MemoryLimits  AGE
  ---------                   ----                         ------------  ----------  ---------------  -------------  ---
  alone                       alone-pod                    0 (0%)        0 (0%)      0 (0%)           0 (0%)        3m2s
  alone                       web-server                   0 (0%)        0 (0%)      0 (0%)           0 (0%)        3m2s
  default                     my-nginx-6b474476c4-2l4cf    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  default                     my-nginx-6b474476c4-mkkz2    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  default                     my-nginx-6b474476c4-mvxg6    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  kube-system                 coredns-f9fd979d6-b2qsx      100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     5m28s
</pre>

**Look what deployment and pods are on our cluster. Preserve them**


`kubectl drain node01 --ignore-daemonsets`{{execute}}

<pre>
node/node01 already cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
error: cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): alone/alone-pod, alone/web-server
</pre>

`kubectl get pod -n alone`{{execute}}
Preserve the alone pods

`kubectl get pod/alone-pod -n alone -o yaml >pod-alone-alone-pod.yaml`{{execute}}

`kubectl get pod/web-server -n alone -o yaml >pod-alone-web-server.yaml`{{execute}}

`kubectl drain node01 --ignore-daemonsets --force `{{execute}}


<pre>
node/node01 already cordoned
WARNING: deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: alone/alone-pod, alone/web-server; ignoring DaemonSet-managed Pods: kube-system/calico-node-pdjlj, kube-system/kube-proxy-kqlkj

evicting pod alone/web-serverevicting pod alone/alone-pod
evicting pod kube-system/calico-kube-controllers-59877c7fb4-fvshd
evicting pod kube-system/coredns-f9fd979d6-hjks6

pod/web-server evicted
pod/calico-kube-controllers-59877c7fb4-fvshd evicted
pod/coredns-f9fd979d6-hjks6 evictedpod/alone-pod evicted
node/node01 evicted
</pre>

**Look what deployment and pods are on our cluster. Preserve them**

`ssh node01`{{execute}}

On node01 node

`apt-get update`{{execute}}

`apt-get install kubelet=1.23.6-00 -y `{{execute}}

Now we should restart kubelet
`systemctl restart kubelet`{{execute}}



On controlplane node

`kubectl uncordon node01`{{execute}}

`kubectl get nodes`{{execute}}

`kubectl get pod -o wide`{{execute}}} 

What we have in alone namespace

`kubectl get all -n alone`{{execute}}} 

If nothing deploy missing object to our cluster

`kubectl apply -f . -n alone`{{execute}}

CHECK

`kubectl get nodes | grep 1.23 | grep Ready | wc -l | grep 2 && echo "done"`{{execute}}

`kubectl get pod alone-pod web-server -n alone | grep Running |wc -l | grep 2 && echo "done"`{{execute}}

CHECK

To continue you should have 1.23 Kubernetes cluster with two nodes (ready)

**To move to the next step make sure to have all checks with "done"**
