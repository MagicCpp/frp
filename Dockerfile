FROM golang:1.10

COPY . /go/src/github.com/fatedier/frp

RUN cd /go/src/github.com/fatedier/frp \
 && make \
 && mkdir -p /var/frp/conf \
 && mv bin/frpc /var/frp/frpc \
 && mv bin/frps /var/frp/frps \
 && cp conf/frpc.ini /var/frp/conf/frpc.ini \
 && cp conf/frps.ini /var/frp/conf/frps.ini \
 && make clean

VOLUME /var/frp/conf

EXPOSE 80 443 6000 7000 7500

WORKDIR /var/frp
ENTRYPOINT ./frpc -c ./conf/frpc.ini
