FROM alpine:3.19.1

# Install the magic wrapper.
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini
ADD ./requirements.txt /requirements.txt
COPY dependencies.json /tmp/dependencies.json

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apk add --no-cache \
    && pip install -r /requirements.txt --break-system-packages \
    && apk del --purge build-dependencies

RUN ln -s /bin/busybox /usr/lib/python3.11/site-packages/gns3server/compute/docker/resources/bin

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

