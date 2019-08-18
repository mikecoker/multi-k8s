docker build -t cokerms/multi-docker-client -t cokerms/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t cokerms/multi-docker-server -t cokerms/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t cokerms/multi-docker-worker -t cokerms/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cokerms/multi-docker-client:latest
docker push cokerms/multi-docker-server:latest
docker push cokerms/multi-docker-worker:latest

docker push cokerms/multi-docker-client:$SHA
docker push cokerms/multi-docker-server:$SHA
docker push cokerms/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cokerms/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=cokerms/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=cokerms/multi-docker-worker:$SHA