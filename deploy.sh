docker build -t aidasb/multi-client:latest -t aidasb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aidasb/multi-server:latest -t aidasb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aidasb/multi-worker:latest -t aidasb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aidasb/multi-client:latest
docker push aidasb/multi-server:latest
docker push aidasb/multi-worker:latest

docker push aidasb/multi-client:$SHA
docker push aidasb/multi-server:$SHA
docker push aidasb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aidasb/multi-server:$SHA
kubectl set image deployments/client-deployment client=aidasb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aidasb/multi-worker:$SHA