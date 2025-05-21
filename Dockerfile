FROM gentoo/stage3

ADD ./scripts/pre_sanity_check.sh			/scripts/pre_sanity_check.sh

ADD ./scripts/start.sh 								/scripts/start.sh
ADD ./scripts/write_package_flags.sh 	/scripts/write_package_flags.sh
ADD ./scripts/install_openssl.sh 			/scripts/install_openssl.sh
ADD ./scripts/install_vpcs.sh 				/scripts/install_vpcs.sh
ADD ./scripts/install_python.sh 			/scripts/install_python.sh

ADD ./config.ini /config.ini
ADD ./requirements.txt /requirements.txt

RUN /scripts/pre_sanity_check.sh

RUN emerge-webrsync

RUN emerge --oneshot -vq dev-lang/go-bootstrap

RUN /scripts/write_package_flags.sh

RUN emerge -vq \
	app-emulation/qemu \
	app-emulation/libvirt \
	app-containers/docker \
	sys-fs/mtools \
	net-misc/ubridge \
	app-emulation/dynamips \
	net-misc/bridge-utils \
	sys-libs/glibc

# VPCS
RUN /scripts/install_vpcs.sh

# IOU support
ENV LD_LIBRARY_PATH="/opt/openssl-0.9.8/lib"
RUN /scripts/install_openssl.sh

# install python & install gns3server
RUN /scripts/install_python.sh

WORKDIR /data
VOLUME ["/data"]

CMD [ "/scripts/start.sh" ]
