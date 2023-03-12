FROM steamcmd/steamcmd:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y xmlstarlet && apt-get clean

WORKDIR /opt/barotrauma

RUN steamcmd +force_install_dir "/opt/barotrauma" +login anonymous +app_update 1026340 validate +quit

RUN mkdir -p /root/.steam/sdk64 && mkdir -p '/root/.local/share/Daedalic Entertainment GmbH/Barotrauma' && ln -s /opt/barotrauma/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

RUN timeout 10 ./DedicatedServer || exit 0 # create config files

ENV LANGUAGE=
ENV SERVER_NAME=
ENV SERVER_MAX_PLAYERS=
ENV GAME_PORT=
ENV QUERY_PORT=
ENV PASSWORD=
ENV IS_PUBLIC=
ENV OWNER_STEAMNAME=
ENV OWNER_STEAMID=

ADD docker-entrypoint.sh /docker-entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "DedicatedServer" ]