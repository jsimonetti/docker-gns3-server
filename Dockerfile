FROM alpine:edge

# Install the magic wrapper.
ADD ./start.sh /start.sh

RUN sed -n "s/main/testing/p" /etc/apk/repositories >> /etc/apk/repositories && \
    mkdir -p /images /symbols /configs /projects /docker /root/GNS3 && \
    ln -sf /images /root/GNS3/images && \
    ln -sf /symbols /root/GNS3/symbols && \
    ln -sf /configs /root/GNS3/configs && \
    ln -sf /projects /root/GNS3/projects && \
    ln -sf /docker /var/lib/docker && \
    apk add --no-cache docker dynamips gns3-server qemu-img qemu-system-x86_64 ubridge vpcs && \
    pip3 install idna && \
    wget -O /usr/bin/vpcs https://github.com/GNS3/vpcs/releases/download/v0.8beta1/vpcs

CMD [ "/start.sh" ]

VOLUME ["/images","/symbols","/configs","/projects","/docker"]

