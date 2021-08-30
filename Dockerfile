FROM alpine:3.14.2

# Install the magic wrapper.
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini

RUN mkdir /data && \
    apk add --no-cache dnsmasq cpulimit docker dynamips qemu-img qemu-system-x86_64 libcap ubridge vpcs wget py3-pip && \
    wget -O /usr/bin/vpcs https://github.com/GNS3/vpcs/releases/download/v0.8beta1/vpcs
RUN apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev linux-headers && \
    pip install gns3-server && \
    apk del .build-deps && \
    rm -rf ~/.cache

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

