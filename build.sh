docker build --no-cache --force-rm=true -t live555 .
docker save -o /NFS/live55docker.tar live555:latest
