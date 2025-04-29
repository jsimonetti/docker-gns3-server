FROM alpine:3.21.3

# Install the magic wrapper.
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini
ADD ./requirements.txt /requirements.txt
COPY ./bin /tmp/bin
# Added tigerVNC to the list as it is required in the v3.0.4 gns3-server.
COPY dependencies.json /tmp/dependencies.json 

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apk add --no-cache \
    && pip install -r /requirements.txt --break-system-packages \
    && apk del --purge build-dependencies

CMD [ "/start.sh" ]

# Workaround for compatibility issue with alpine's busybox in Docker containers.
# See: https://github.com/GNS3/gns3-server/issues/2069

RUN cp /tmp/bin/busybox /usr/lib/python*/site-packages/gns3server/compute/docker/resources/bin


WORKDIR /data

VOLUME ["/data"]
