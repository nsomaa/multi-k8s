docker build -t nsoma75/multi-client:latest -t nsoma75/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nsoma75/multi-server:latest -t nsoma75/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t nsoma75/multi-worker:latest -t nsoma75/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push nsoma75/multi-client:latest
docker push nsoma75/multi-server:latest
docker push nsoma75/multi-worker:latest
docker push nsoma75/multi-client:$SHA
docker push nsoma75/multi-server:$SHA
docker push nsoma75/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nsoma75/multi-server:$SHA
kubectl set image deployments/client-deployment client=nsoma75/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nsoma75/multi-worker:$SHA
