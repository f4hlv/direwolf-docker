FROM alpine:latest

ENV DIREWOLF_BRANCH=master \
    BUILD_DEPS="build-base cmake git alsa-lib-dev avahi-dev" \
    RUNTIME_DEPS="alsa-lib libgcc libstdc++ avahi dbus supervisor"

RUN apk add --no-cache $BUILD_DEPS $RUNTIME_DEPS \
    && git clone https://github.com/wb2osz/direwolf.git /tmp/direwolf \
    && cd /tmp/direwolf \
    && git checkout $DIREWOLF_BRANCH \
    && mkdir build && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && make install-conf \
    && rm -rf /tmp/direwolf \
    && apk del $BUILD_DEPS

# Config Supervisor
RUN mkdir -p /etc/supervisor.d /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf

# Config dbus
RUN mkdir -p /var/run/dbus && chmod 755 /var/run/dbus

WORKDIR /usr/local/etc/direwolf
COPY direwolf.conf /usr/local/etc/direwolf/direwolf.conf
EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]