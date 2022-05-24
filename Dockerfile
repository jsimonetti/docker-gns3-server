FROM alpine:3.16.0

# Install the magic wrapper.
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini
ADD ./requirements.txt /requirements.txt
COPY dependencies.json /tmp/dependencies.json

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apk add --no-cache \
    && pip install -r /requirements.txt \
    && apk del --purge build-dependencies

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

