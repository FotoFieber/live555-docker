FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y wget
RUN wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz
RUN tar -xzf live555-latest.tar.gz
COPY /OutPacketBuffer.diff /
RUN patch -p0 -i OutPacketBuffer.diff
#COPY /live /live
WORKDIR live
RUN ./genMakefiles linux
RUN make
#RUN cp  /live/proxyServer/live555ProxyServer /usr/bin
#RUN apt-get remove -y build-essential
#RUN apt-get remove -y wget
#RUN apt-get -y autoremove
#RUN rm -rf /var/lib/apt/lists/*

FROM ubuntu:18.04
RUN apt-get update -y
COPY --from=0 /live/proxyServer/live555ProxyServer /usr/bin
WORKDIR /
ADD /startup.sh /
EXPOSE 554
CMD /startup.sh