docker build -t chickenmelike/multi-client:latest -t chickenmelike/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chickenmelike/multi-server:latest -t chickenmelike/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chickenmelike/multi-worker:latest -t chickenmelike/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chickenmelike/multi-client:latest
docker push chickenmelike/multi-server:latest
docker push chickenmelike/multi-worker:latest

docker push chickenmelike/multi-client:$SHA
docker push chickenmelike/multi-server:$SHA
docker push chickenmelike/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=chickenmelike/multi-client:$SHA
kubectl set image deployments/server-deployment server=chickenmelike/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=chickenmelike/multi-worker:$SHA
