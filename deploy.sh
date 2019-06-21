docker build -t kareemelkasaby/multi-client:$SHA -t kareemelkasaby/multi-client:latest -f ./client/Dockerfile ./client
docker build -t kareemelkasaby/multi-server:$SHA -t kareemelkasaby/multi-server:latest -f ./server/Dockerfile ./server
docker build -t kareemelkasaby/multi-worker:$SHA -t kareemelkasaby/multi-worker:latest -f ./worker/Dockerfile ./worker

docker push kareemelkasaby/multi-client:$SHA
docker push kareemelkasaby/multi-server:$SHA
docker push kareemelkasaby/multi-worker:$SHA

docker push kareemelkasaby/multi-client:latest
docker push kareemelkasaby/multi-server:latest
docker push kareemelkasaby/multi-worker:latest


kubectl apply -f k8s
kubectl set image deployment/client-deployment client=kareemelkasaby/multi-client:$SHA
kubectl set image deployment/server-deployment server=kareemelkasaby/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=kareemelkasaby/multi-worker:$SHA