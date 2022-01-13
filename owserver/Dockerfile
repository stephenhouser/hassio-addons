ARG BUILD_FROM
FROM $BUILD_FROM as builder

RUN apk update \
 && apk add build-base libusb-dev

# Build only `owserver` and build with USB support
RUN wget https://github.com/owfs/owfs/releases/download/v3.2p4/owfs-3.2p4.tar.gz \
 && tar xzvf owfs-3.2p4.tar.gz \
 && cd owfs-3.2p4 \
 && ./configure \
	--prefix=/usr/local \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	--with-fuseinclude=/usr/include \
	--with-fuselib=/usr/lib \
	--disable-w1 \
	--disable-i2c \
	--disable-owfs --disable-owhttpd --disable-owftpd --disable-owshell \
	--disable-ownet --disable-owtap --disable-owmon --disable-owexternal \
 && make install

COPY owfs.conf /etc/owfs.conf
COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 4304
CMD [ "/run.sh" ]
