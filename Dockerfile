FROM ubuntu:16.04

ENV STEAM_HOME "/var/lib/steam"

RUN apt-get update \
    && apt-get install -y \
        sudo \
        wget \
        lib32gcc1 \
    && wget -O "/tmp/steamcmd_linux.tar.gz" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && mkdir -p "${STEAM_HOME}" \
    && tar -xf "/tmp/steamcmd_linux.tar.gz" -C "${STEAM_HOME}" \
    && useradd -d "${STEAM_HOME}" -s /bin/false -r steam \
    && chown steam:steam -R "${STEAM_HOME}" \
    && cd "${STEAM_HOME}" && sudo -H -u steam "./steamcmd.sh" +quit \
    && SUDO_FORCE_REMOVE=yes apt-get remove -y sudo wget \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf "/var/lib/apt/lists/*" \
    && rm -rf "/tmp/*"

USER steam

WORKDIR "${STEAM_HOME}"

ENTRYPOINT "./steamcmd.sh"
