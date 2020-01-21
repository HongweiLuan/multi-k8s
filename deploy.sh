docker build -t hluandeloitte/multi-client:latest -t hluandeloitte/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hluandeloitte/multi-server:latest -t hluandeloitte/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hluandeloitte/multi-worker:latest -t hluandeloitte/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hluandeloitte/multi-client:latest
docker push hluandeloitte/multi-server:latest
docker push hluandeloitte/multi-worker:latest

docker push hluandeloitte/multi-client:$SHA
docker push hluandeloitte/multi-server:$SHA
docker push hluandeloitte/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hluandeloitte/multi-server:$SHA
kubectl set image deployments/client-deployment client=hluandeloitte/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hluandeloitte/multi-worker:$SHA
