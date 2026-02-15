# 
FROM alpine:3.20 AS build

RUN apk add --no-cache \
    build-base \
    git \
    cmake \
    linux-headers \
    alsa-lib-dev \
    libudev-zero-dev \
    ncurses-dev \
    readline-dev \
    libgpiod-dev

WORKDIR /src
RUN git clone --depth=1 https://github.com/wb2osz/direwolf.git .

RUN mkdir -p build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j"$(nproc)" && \
    cmake --install .

# --- Étape de production ---
FROM alpine:3.20

RUN apk add --no-cache \
    alsa-lib \
    libudev-zero \
    ncurses-libs \
    readline \
    tzdata \
    libgpiod \
    ca-certificates

COPY --from=build /usr/local /usr/local

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# USER direwolf
WORKDIR /var/lib/direwolf

ENV DW_CONFIG=/etc/direwolf/direwolf.conf
ENV TZ=Europe/Paris

ENTRYPOINT ["/entrypoint.sh"]
CMD ["direwolf", "-c", "/etc/direwolf/direwolf.conf", "-t", "0"]
