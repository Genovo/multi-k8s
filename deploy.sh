docker build -t genovo/multi-client:latest -t genovo/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t genovo/multi-server:latest -t genovo/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t genovo/multi-worker:latest -t genovo/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push genovo/multi-client:latest
docker push genovo/multi-server:latest
docker push genovo/multi-worker:latest
docker push genovo/multi-client:$GIT_SHA
docker push genovo/multi-server:$GIT_SHA
docker push genovo/multi-worker:$GIT_SHA

kubectl apply -f /k8s

kubectl set image deployments/client-deployment client=genovo/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=genovo/multi-server$GIT_SHA
kubectl set image deployments/worker-deployment worker=genovo/multi-worker:$GIT_SHA

