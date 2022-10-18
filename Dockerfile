FROM alpine:3

# Install the magic wrapper.
ARG GNS3_VERS=2.2.34
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini
COPY dependencies.json /tmp/dependencies.json

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apk add --no-cache
RUN pip install gns3-server==$GNS3_VERS
RUN apk del --purge build-dependencies

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

