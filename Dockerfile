FROM alpine:edge

RUN sed -n "s/main/testing/p" /etc/apk/repositories >> /etc/apk/repositories && \
    apk add --no-cache dynamips gns3-server qemu-img qemu-system-x86_64 ubridge vpcs && \
    pip3 install idna>=2.0


CMD ["gns3server"]

EXPOSE 3080

VOLUME ["/opt/gns3/images","/opt/gns3/symbols","/opt/gns3/configs","/opt/gns3/projects"]

