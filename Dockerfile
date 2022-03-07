FROM ubuntu:latest
RUN apt update && apt install build-essential -f -y && mkdir /app
WORKDIR /app
ADD https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.38-9760-rtm/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz /app/tar.tar.gz
RUN tar xvzf tar.tar.gz && cd vpnserver && mv * .install.sh  .. && cd .. && rm -rf vpnserver
RUN make
RUN ./vpnserver start
VOLUME /app/server_log
VOLUME /app/security_log
ENTRYPOINT ["/app/vpnserver", "execsvc"]
