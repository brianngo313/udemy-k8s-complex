docker build -t brianngo313/multi-client:latest -t brianngo313/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brianngo313/multi-server:latest -t brianngo313/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t brianngo313/multi-worker:latest -t brianngo313/multi-client:$SHA -f ./worker/Dockerfile ./worker

docker push brianngo313/multi-client:latest
docker push brianngo313/multi-server:latest
docker push brianngo313/multi-worker:latest

docker push brianngo313/multi-client:$SHA
docker push brianngo313/multi-server:$SHA
docker push brianngo313/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=brianngo313/multi-client:$SHA
kubectl set image deployments/server-deployment server=brianngo313/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=brianngo313/multi-worker:$SHA