FROM ubuntu:16.04

ARG STEAM_HOME="/usr/local/steam"

ENV STEAM_HOME="${STEAM_HOME}"

RUN apt-get update \
    && apt-get install -y \
        wget \
        lib32gcc1 \
    && wget -O "/tmp/steamcmd_linux.tar.gz" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && mkdir -p "${STEAM_HOME}" \
    && tar -xf "/tmp/steamcmd_linux.tar.gz" -C "${STEAM_HOME}" \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf "/var/lib/apt/lists/*" \
    && rm -rf "/tmp/*"

WORKDIR "${STEAM_HOME}"

ENTRYPOINT "${STEAM_HOME}/steamcmd.sh"
