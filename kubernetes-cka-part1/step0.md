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

For example, for following command will initialise the control plane with the latest version installed.

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


Now you can check your access to your k8s cluster

`kubectl get nodes`{{execute}}

<pre>
NAME           STATUS   ROLES                  AGE     VERSION
controlplane   Ready    control-plane,master   3m10s   v1.23.6
</pre>

We are almost at the end ?

Create an example deployment in default namespace:

 `kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml`{{execute}}


`kubectl get pod -n default`{{execute}} 

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

Control plane node is ready. What about worker nodes?

Let's try to add worker node/nodes.

`ssh node01`{{execute}}

On worker node (node01) execute kubeadm join command.

Return to controlplane node

`exit`{{copy}}


`kubectl get pod -n default`{{execute}} 
<pre>
NAME                        READY   STATUS              RESTARTS   AGE
my-nginx-66b6c48dd5-l8m6r   0/1     ContainerCreating   0          8m29s
my-nginx-66b6c48dd5-r88c9   0/1     ContainerCreating   0          8m29s
my-nginx-66b6c48dd5-z4szd   0/1     ContainerCreating   0          8m29s
</pre>

`kubectl describe pod -l app=nginx | grep Events -A5`{{execute}}

<pre>
TODO 
</pre>

We did not deploy network to kubernetes cluster!

Initialize cluster networking (CNI):


Here we have Calico CNI

`kubectl apply -f https://raw.githubusercontent.com/djkormo/killercoda-scenarios/main/kubernetes-cka-part1/calico.yaml`{{execute}}



`kubectl get pod -n default`{{execute}} 
<pre>
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-l8m6r   1/1     Running   0          13m
my-nginx-66b6c48dd5-r88c9   1/1     Running   0          13m
my-nginx-66b6c48dd5-z4szd   1/1     Running   0          13m
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
