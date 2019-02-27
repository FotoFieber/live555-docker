docker stop rtspproxy
docker rm rtspproxy
docker run --restart=always -it -p 0.0.0.0:554:554 --name rtspproxy live555:latest 
