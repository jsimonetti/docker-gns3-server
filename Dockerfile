FROM gns3/ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

ADD ./start.sh /start.sh
ADD ./config.ini /config.ini
ADD ./requirements.txt /requirements.txt
COPY dependencies.json /tmp/dependencies.json

RUN mkdir /data && \
	apt update && apt install -y \
	cpulimit \
	dnsmasq \
	docker.io \
	dynamips \
	libcap2-bin \
	python3-pip \
	qemu-utils \
	qemu-system-x86 \
	util-linux \
	bridge-utils \
	iptables \
	software-properties-common \
	wget

RUN add-apt-repository -y ppa:gns3/ppa && \
	apt update && apt install -y \
	ubridge vpcs

# IOU
RUN dpkg --add-architecture i386 && apt update
RUN apt install -y \
	libc6:i386 \
	libstdc++6:i386 \
	libncurses6:i386 \
	libtinfo6:i386 \
	libelf1:i386

# openssl i386
# https://linuxsoft.cern.ch/cern/slc5X/x86_64/yum/updates/repoview/openssl097a.html
RUN apt install -y \
	rpm2cpio \
	cpio

COPY openssl097a-*.rpm /tmp/
RUN cd /tmp && \
	rpm2cpio openssl097a-*.rpm | cpio -idmv && \
	cp ./lib/libcrypto.so.4 /lib/i386-linux-gnu/

# libkrb
RUN apt install -y \
	libkrb5-3:i386 \
	libgssapi-krb5-2:i386 \
	libk5crypto3:i386 \
	libcom-err2:i386

RUN pip3 install --break-system-packages -r /requirements.txt

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

