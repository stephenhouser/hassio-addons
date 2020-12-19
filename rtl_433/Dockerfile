ARG BUILD_FROM
FROM scratch as caching-downloader

ADD https://github.com/merbanan/rtl_433/archive/master.tar.gz /rtl_433.tar.gz
#ADD https://github.com/merbanan/rtl_433/archive/20.02.tar.gz /rtl_433.tar.gz
ADD https://github.com/osmocom/rtl-sdr/archive/0.6.0.tar.gz /rtl_sdr.tar.gz

FROM $BUILD_FROM as builder

ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib64:/usr/local/lib"

RUN apk add --no-cache --update cmake build-base libusb-dev bash

COPY --from=caching-downloader / /tmp

RUN mkdir -p /build/rtl_433 /build/rtl_sdr && \
    tar -zxvf /tmp/rtl_433.tar.gz -C /build/rtl_433 --strip-components=1 && \
    tar -zxvf /tmp/rtl_sdr.tar.gz -C /build/rtl_sdr --strip-components=1

RUN mkdir /build/rtl_sdr/out && cd /build/rtl_sdr/out && \
    cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON && \
    make  && \
    make install

RUN mkdir /build/rtl_433/out && cd /build/rtl_433/out && \
    cmake ../ && \
    make && \
    make install

RUN echo 'blacklist dvb_usb_rtl28xxu' > /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf

FROM $BUILD_FROM

MAINTAINER stephenhouser@gmail.com

ENV RTL_OPTS=""
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib64:/usr/local/lib"

WORKDIR /

RUN apk add --no-cache --update libusb python3 py3-pip
RUN pip3 install paho-mqtt

COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
COPY --from=builder /etc/udev/rules.d/rtl-sdr.rules /etc/udev/rules.d/rtl-sdr.rules
#COPY --from=builder /build/rtl_433/examples/rtl_433_mqtt_hass.py /rtl_433_mqtt_hass.py
RUN curl https://raw.githubusercontent.com/stephenhouser/rtl_433/develop/examples/rtl_433_mqtt_hass.py > /rtl_433_mqtt_hass.py
COPY entrypoint.sh /entrypoint.sh

#RUN adduser -D -H user -G usb
#USER user

ENTRYPOINT /entrypoint.sh $RTL_OPTS
