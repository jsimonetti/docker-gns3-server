FROM amitie10g/alpine-supervisord AS dependencies

ADD ./config.ini /config.ini
COPY dependencies.json /tmp/dependencies.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /data && \
    apk add --no-cache --virtual=build-dependencies jq gcc python3-dev musl-dev linux-headers \
    && jq -r 'to_entries | .[] | .key + "=" + .value' /tmp/dependencies.json | xargs apk add --no-cache

FROM dependencies as required
ARG GNS3_VERS=2.2.34
RUN pip install gns3-server==$GNS3_VERS

FROM required as cleanup
RUN apk del --purge build-dependencies

WORKDIR /data

VOLUME ["/data"]
