**Step 0**

**Install cluster with kubeadm** 

Let's try to control remainning time to reset our sandbox

<pre>
58 min root@controlplane
</pre>

It means that you have only 58 minutes to finish the lab!!

**Hurry up!**


If you need a cluster available.... let's make our hands go to work...


The Kubernetes nodes are not configured. If you want to configure the nodes then you'd need to run kubeadm which has been set and configured. 


`kubeadm version -o short`{{execute}}

We are going to install 1.22.x version

Let's download images 

`kubeadm config images pull --kubernetes-version $(kubeadm version -o short) `{{execute}}

For example the following command will initialise the control plane with the latest version installed.

`kubeadm init --kubernetes-version $(kubeadm version -o short) --pod-network-cidr 192.168.0.0/16`{{execute}}

If you see the error
<pre>
[ERROR NumCPU]: the number of available CPUs 1 is less than the required 2   
</pre>

Add **--ignore-preflight-errors=NumCPU**

`kubeadm init --kubernetes-version $(kubeadm version -o short) --pod-network-cidr 192.168.0.0/16 --ignore-preflight-errors=NumCPU`{{execute}} 

Move cluster config file to your home directory.

`mkdir -p $HOME/.kube &&
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config &&
sudo chown $(id -u):$(id -g) $HOME/.kube/config`{{execute}}


From now you can check your access to your k8s cluster using kubectl

`kubectl get nodes`{{execute}}

<pre>
NAME           STATUS     ROLES                  AGE   VERSION
controlplane   NotReady   control-plane,master   28s   v1.22.10
</pre>


We are almost at the end ?

Create an example deployment in default namespace:

 `kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml -n default `{{execute}}


`kubectl get pod -n default`{{execute}} 
<pre>
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-45hqd   0/1     Pending   0          2s
my-nginx-66b6c48dd5-6244g   0/1     Pending   0          2s
my-nginx-66b6c48dd5-mjxj9   0/1     Pending   0          2s
</pre>

They all in Pending state. Let's check why.

`kubectl describe pod -l app=nginx | grep Events -A5`{{execute}}

<pre>
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  45s (x4 over 3m53s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.


--
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  45s (x4 over 3m53s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.


--
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  15s (x4 over 3m53s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
</pre>

Control plane has a taint to keep away application workload from it.

Control plane node is also not ready and what about worker nodes?


Let's try to add worker node/nodes.

`ssh node01`{{execute}}

On worker node (node01) execute kubeadm join command.

Return to controlplane node

`exit`{{copy}}


How looks our cluster ?

`kubectl get nodes`{{execute}}

<pre>
NAME           STATUS     ROLES                  AGE     VERSION
controlplane   NotReady   control-plane,master   9m6s    v1.22.10
node01         NotReady   <none>                 2m45s   v1.22.10
</pre>

How look our pods ?

`kubectl get pod -n default`{{execute}} 
<pre>
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-45hqd   0/1     Pending   0          5m30s
my-nginx-66b6c48dd5-6244g   0/1     Pending   0          5m30s
my-nginx-66b6c48dd5-mjxj9   0/1     Pending   0          5m30s
</pre>

`kubectl describe pod -l app=nginx | grep Events -A7`{{execute}}

<pre>
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  64s (x5 over 5m39s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
  Warning  FailedScheduling  4s                   default-scheduler  0/2 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate, 1 node(s) had taint {node.kubernetes.io/not-ready: }, that the pod didn't tolerate.


Name:           my-nginx-66b6c48dd5-6244g
--
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  34s (x5 over 5m39s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.


Name:           my-nginx-66b6c48dd5-mjxj9
Namespace:      default
--
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  64s (x5 over 5m39s)  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
  Warning  FailedScheduling  4s                   default-scheduler  0/2 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate, 1 node(s) had taint {node.kubernetes.io/not-ready: }, that the pod didn't tolerate.
</pre>

We did not deploy network to kubernetes cluster!

Initialize cluster networking (CNI):


Here we have Calico CNI

`kubectl apply -f https://raw.githubusercontent.com/djkormo/killercoda-scenarios/main/kubernetes-cka-part1/calico.yaml`{{execute}}



`kubectl get pod -n default`{{execute}} 
<pre>
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-45hqd   1/1     Running   0          16m
my-nginx-66b6c48dd5-6244g   1/1     Running   0          16m
my-nginx-66b6c48dd5-mjxj9   1/1     Running   0          16m
</pre>

So what if do not have my token or token is invalid?

**Hint**

How to get token for join command?

`kubeadm token create --print-join-command`{{execute}}

List of all generated tokens

`kubeadm token list`{{execute}}

Let's examine our cluster

`kubectl cluster-info`{{execute}}

Number of cluster nodes

`kubectl get nodes`{{execute}}

Example objects in default namespace

`kubectl get all,ep -o wide`{{execute}}

We have reached our check point!


CHECK

N

`kubectl get nodes | grep 1.22 | grep Ready | wc -l | grep 2 && echo "done"`{{execute}}

CHECK

List pods in kube-system namespace
`kubectl get pod -n kube-system`{{execute}}


To continue you should have 1.22.x Kubernetes cluster with two nodes (ready)

**To move to the next step make sure to have all checks with "done"**
