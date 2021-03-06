https://training.linuxfoundation.org/cka-program-changes-2020/


**Cluster Architecture, Installation & Configuration – 25%**

1. Manage role based access control (RBAC)
https://kubernetes.io/docs/reference/access-authn-authz/rbac/

2. Use Kubeadm to install a basic cluster
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/


3. Manage a highly-available Kubernetes cluster
https://kubernetes.io/docs/tasks/administer-cluster/highly-available-master/


4. Provision underlying infrastructure to deploy a Kubernetes cluster
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

5. Perform a version upgrade on a Kubernetes cluster using Kubeadm
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

6. Implement etcd backup and restore
https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/

**Bonus:**
Kubeadm deep dive
https://youtu.be/DhsFfNSIrQ4


## Detailed links:


### Manage Role-based Access Control (RBAC)
Configure RBAC in your Kubernetes cluster
https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/


#### Other material related to Kubernetes RBAC:

Using RBAC authorization
https://kubernetes.io/docs/reference/access-authn-authz/rbac/

Understand Role-based access control in Kubernetes
https://www.youtube.com/watch?v=G3R24JSlGjY

RBAC support in Kubernetes
https://kubernetes.io/blog/2017/04/rbac-support-in-kubernetes/


3 realistic approaches to Kubernetes RBAC
https://thenewstack.io/three-realistic-approaches-to-kubernetes-rbac/


Demystifying RBAC in Kubernetes
https://www.cncf.io/blog/2018/08/01/demystifying-rbac-in-kubernetes/


Kubernetes RBAC 101: Authorization
https://www.cncf.io/blog/2020/08/28/kubernetes-rbac-101-authorization/

### Use Kubeadm to Install a Basic Cluster

Creating a cluster with kubeadm
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

Installing kubeadm toolbox
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

Creating Highly Available clusters with kubeadm
https://www.padok.fr/en/blog/kubeadm-kubernetes-cluster

Set up a bare-metal Kubernetes cluster with kubeadm
https://www.padok.fr/en/blog/kubeadm-kubernetes-cluster

Installing Kubernetes with Kubeadm: A quick and dirty guide
https://www.mirantis.com/blog/how-install-kubernetes-kubeadm/

#### Installing a cluster on Ubuntu

Create a Kubernetes Cluster Using Kubeadm
https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04

Install a Kubernetes cluster on Ubuntu step-by-step
https://medium.com/htc-research-engineering-blog/install-a-kubernetes-cluster-with-kubeadm-on-ubuntu-step-by-stepff-c118514bc5e0

### Manage a Highly-available Kubernetes Cluster

Options for Highly Available topology
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/

Set up High-Availability Kubernetes Masters
https://kubernetes.io/docs/tasks/administer-cluster/highly-available-master/

Setup highly available Kubernetes cluster with Kubeadm
https://www.linuxtechi.com/setup-highly-available-kubernetes-cluster-kubeadm/

Creating Highly Available clusters with kubeadm
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/


#### Other blog posts to refer

Building high-availability clusters
http://pwittrock.github.io/docs/admin/high-availability/

Running Highly Available Clusters with Kubeadm
https://www.weave.works/blog/running-highly-available-clusters-with-kubeadm

Demystifying high availability in Kubernetes using Kubeadm
https://medium.com/velotio-perspectives/demystifying-high-availability-in-kubernetes-using-kubeadm-3d83ed8c458b

Kubernetes high availability: No single point of failure
https://thenewstack.io/kubernetes-high-availability-no-single-point-of-failure/

Deploy a HA Kubernetes cluster on CentOS7
https://www.kubeclusters.com/docs/How-to-Deploy-a-Highly-Available-kubernetes-Cluster-with-Kubeadm-on-CentOS7

High availability Kubernetes on bare metal
https://www.youtube.com/watch?v=ojZT1sKCGQs

Highly available Kubernetes clusters best practices
https://www.youtube.com/watch?v=NpT9RraqKdY

### Provision Underlying Infrastructure to Deploy a Kubernetes Cluster

Kubernetes infrastructure
https://docs.openshift.com/enterprise/3.0/architecture/infrastructure_components/kubernetes_infrastructure.html

Deploy an AKS cluster using the Azure portal
https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal

Deploy a production-grade Kubernetes cluster on AWS
https://gruntwork.io/guides/kubernetes/how-to-deploy-production-grade-kubernetes-cluster-aws/#interacting-with-kubernetes

Cloud Infrastructure Provisioning – Google Cloud Platform
https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/f9486b081f8f54dd63a891463f0b0e783d084307/docs/01-infrastructure-gcp.md


What is Kubernetes infrastructure?
https://www.vmware.com/topics/glossary/content/kubernetes-infrastructure

Deploy Kubernetes on hosted cloud infrastructure
https://platform9.com/docs/deploy-kubernetes-the-ultimate-guide/#:~:text=Deploy%20Kubernetes%20on%20Hosted%20Cloud%20Infrastructure

### Perform a Version Upgrade on a Kubernetes Cluster Using Kubeadm

Kubeadm upgrade
https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/

Upgrading kubeadm clusters
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

Kubernetes upgrade: The definitive guide to Do-It-Yourself
https://platform9.com/blog/kubernetes-upgrade-the-definitive-guide-to-do-it-yourself/

Upgrading clusters to newer Kubernetes versions
https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutupgradingclusters.htm

Upgrading self-hosted Kubernetes
https://coreos.com/matchbox/docs/latest/bootkube-upgrades.html

#### Upgrading Kubernetes in Cloud providers

How we upgrade Kubernetes on GKE?
https://blog.gojekengineering.com/how-we-upgrade-kubernetes-on-gke-91812978a055

Updating an Amazon EKS cluster Kubernetes version
https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html

Upgrade an Azure Kubernetes Service (AKS) cluster
https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster

Rancher – upgrading Kubernetes
https://rancher.com/docs/rancher/v1.6/en/kubernetes/upgrading/

### Implement etcd Backup and Restore

Backing up an etcd cluster
https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster

Restoring an etcd cluster
https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#restoring-an-etcd-cluster

Backup & restore a Kubernetes master with Kubeadm
https://docs.kublr.com/articles/backup/etcd-backup/

#### Other articles on etcd backup & restore

Backup and Restore of etcd database
https://docs.kublr.com/articles/backup/etcd-backup/

Kubernetes tips: Backup and restore etcd
https://medium.com/better-programming/kubernetes-tips-backup-and-restore-etcd-97fe12e56c57

YouTube: Implement etcd backup & restore
https://www.youtube.com/watch?v=_6BMGnnySrc
