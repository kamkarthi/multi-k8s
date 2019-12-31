docker build -t kamkarthi/multi-client:latest -t kamkarthi/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t kamkarthi/multi-server:latest -t kamkarthi/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t kamkarthi/multi-worker:latest -t kamkarthi/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push kamkarthi/multi-client:latest
docker push kamkarthi/multi-server:latest
docker push kamkarthi/multi-worker:latest

docker push kamkarthi/multi-client:$GIT_SHA
docker push kamkarthi/multi-server:$GIT_SHA
docker push kamkarthi/multi-worker:$GIT_SHA

kubectl apply -f k8s/

kubectl set image deployments/client-deployment client=kamkarthi/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=kamkarthi/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=kamkarthi/multi-worker:$GIT_SHA