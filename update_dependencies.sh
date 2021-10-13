#!/bin/bash
set -e
apt -yy install wget jq python
VERSION=$(grep '^FROM' Dockerfile | sed -e 's/.*://' -e 's/.[0-9]$//')
wget -r -l1 -nd --no-parent "http://dl-cdn.alpinelinux.org/alpine/v${VERSION}/main/x86/" -P /tmp -A "apk-tools-static-*.apk"
tar xf /tmp/apk-tools-static-*.apk -C /tmp
/tmp/sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/v${VERSION}/main -U --allow-untrusted --initdb add apk-tools
echo "http://dl-cdn.alpinelinux.org/alpine/v${VERSION}/main" >> /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/v${VERSION}/community" >> /etc/apk/repositories
/tmp/sbin/apk.static update --allow-untrusted

JSON=$( cat dependencies.json )

for PACKAGE in $( echo $JSON | jq -r 'keys | .[]' ); do
	VERSION=$( /tmp/sbin/apk.static list "$PACKAGE" --allow-untrusted | awk '{ print $1 }' | sed -e "s/^${PACKAGE}-//" )
	JSON=$( echo $JSON | jq '.[$package] = $version' --arg package $PACKAGE --arg version $VERSION )
done

echo $JSON | python -m json.tool > dependencies.json

