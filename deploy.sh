docker build -t brianngo313/multi-client -f ./client/Dockerfile ./client
docker build -t brianngo313/multi-server -f ./server/Dockerfile ./server
docker build -t brianngo313/multi-worker -f ./worker/Dockerfile ./worker
docker push brianngo313/multi-client
docker push brianngo313/multi-server
docker push brianngo313/multi-worker
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=brianngo313/multi-client
kubectl set image deployments/server-deployment server=brianngo313/multi-server
kubectl set image deployments/worker-deployment worker=brianngo313/multi-worker