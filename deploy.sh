docker build -t kailashxii/multi-client-k8s:latest -t kailashxii/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t kailashxii/multi-server-k8s-pgfix:latest -t kailashxii/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t kailashxii/multi-worker-k8s:latest -t kailashxii/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push kailashxii/multi-client-k8s:latest
docker push kailashxii/multi-server-k8s-pgfix:latest
docker push kailashxii/multi-worker-k8s:latest

docker push kailashxii/multi-client-k8s:$SHA
docker push kailashxii/multi-server-k8s-pgfix:$SHA
docker push kailashxii/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kailashxii/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=kailashxii/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=kailashxii/multi-worker-k8s:$SHA
