FROM alpine

RUN apk add --no-cache git alsa-lib alsa-lib-dev linux-headers build-base && \
    git clone https://github.com/wb2osz/direwolf.git /tmp/direwolf && \
    echo "#include <unistd.h>" > /usr/include/sys/unistd.h && \
    cd /tmp/direwolf && \
    sed -i 's/--mode=/-m /g' Makefile.linux && \
    sed -i 's/cp -n/cp/g' Makefile.linux && \
    CFLAGS=-D__FreeBSD__ make && make install && \
    cd / && rm -r /tmp/direwolf /usr/include/sys/unistd.h && \
    find /usr/local/bin -type f -exec strip -p --strip-debug {} \; && \
    apk del git alsa-lib-dev linux-headers build-base

VOLUME /direwolf
WORKDIR /direwolf

CMD direwolf -c /direwolf/direwolf.conf
