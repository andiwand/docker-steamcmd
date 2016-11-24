FROM ubuntu:16.04

ENV STEAM_HOME "/var/lib/stream"

RUN apt-get update \
    && apt-get install -y \
        wget \
        lib32gcc1 \
    && wget -O "/tmp/steamcmd_linux.tar.gz" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && mkdir -p "${STEAM_HOME}" \
    && tar -xf "/tmp/steamcmd_linux.tar.gz" -C "${STEAM_HOME}" \
    && useradd -d "${STEAM_HOME}" -s /bin/false -r steam \
    && chown steam:steam -R "${STEAM_HOME}" \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf "/var/lib/apt/lists/*" \
    && rm -rf "/tmp/*"

USER steam

VOLUME "${STEAM_HOME}"

WORKDIR "${STEAM_HOME}"

ENTRYPOINT "./steamcmd.sh"
