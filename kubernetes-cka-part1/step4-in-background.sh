kubectl delete deploy --all -n default
kubectl delete svc --all -n default
kubectl create namespace office --dry-run=client -o yaml | kubectl apply -f -


