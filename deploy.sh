docker build -t will518/multi-client-k8s:latest -t will518/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t will518/multi-server-k8s:latest -t will518/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t will518/multi-worker-k8s:latest -t will518/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push will518/multi-client-k8s:latest
docker push will518/multi-server-k8s:latest
docker push will518/multi-worker-k8s:latest

docker push will518/multi-client-k8s:$SHA
docker push will518/multi-server-k8s:$SHA
docker push will518/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=will518/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=will518/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=will518/multi-worker-k8s:$SHA