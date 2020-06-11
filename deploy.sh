docker build -t srikarrampally/multi-client:latest -t srikarrampally/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t srikarrampally/multi-server:latest -t srikarrampally/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t srikarrampally/multi-worker:latest -t srikarrampally/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push srikarrampally/multi-client:latest
docker push srikarrampally/multi-server:latest
docker push srikarrampally/multi-worker:latest

docker push srikarrampally/multi-client:$SHA
docker push srikarrampally/multi-server:$SHA
docker push srikarrampally/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=srikarrampally/multi-client:$SHA
kubectl set image deployments/server-deployment server=srikarrampally/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=srikarrampally/multi-worker:$SHA