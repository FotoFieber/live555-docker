FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y wget
RUN apt-get install -y openssl libssl-dev
RUN wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz
RUN tar -xzf live555-latest.tar.gz
COPY /OutPacketBuffer.diff /
RUN patch -p0 -i OutPacketBuffer.diff
WORKDIR live
RUN ./genMakefiles linux
RUN make

FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install -y openssl 
COPY --from=0 /live/proxyServer/live555ProxyServer /usr/bin
WORKDIR /
ADD /startup.sh /
EXPOSE 554
CMD /startup.sh
