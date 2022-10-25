FROM amitie10g/alpine-supervisord AS dependencies

ADD ./config.ini /config.ini
COPY config/* /etc/supervisor/conf.d/
COPY start.sh /usr/local/bin/start-gns3

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers py3-pip && \
    apk add \
        cpulimit \
        dnsmasq \
        docker \
        dynamips \
        libcap \
        qemu-img \
        qemu-system-x86_64 \
        ubridge \
        vpcs

FROM dependencies as required
ARG GNS3_VERS=2.2.34
RUN pip install gns3-server==$GNS3_VERS

FROM required as cleanup
RUN apk del --purge build-dependencies

WORKDIR /data

VOLUME ["/data"]
