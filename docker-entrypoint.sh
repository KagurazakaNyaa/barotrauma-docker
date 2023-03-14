#!/bin/bash
set -e

mkdir -p /data/config /data/mods /data/saves /data/submarines

if [[ ! -f /data/config/config_player.xml ]];then
    mv config_player.xml /data/config/config_player.xml
else
    rm config_player.xml
fi
if [[ ! -f /data/config/serversettings.xml ]];then
    mv serversettings.xml /data/config/serversettings.xml
else
    rm serversettings.xml
fi
if [[ ! -d /data/config/Data ]];then
    mv Data /data/config/Data
else
    rm -rf Data
fi
mkdir -p Submarines '/root/.local/share/Daedalic Entertainment GmbH/Barotrauma'
rm -rf LocalMods
ln -sf /data/config/config_player.xml config_player.xml
ln -sf /data/config/serversettings.xml serversettings.xml
ln -sf /data/config/Data Data
ln -sf /data/mods LocalMods
if [[ ! -L '/root/.local/share/Daedalic Entertainment GmbH/Barotrauma/Multiplayer' ]];then
    ln -sf /data/saves '/root/.local/share/Daedalic Entertainment GmbH/Barotrauma/Multiplayer'
fi
if [[ ! -L Submarines/Added ]];then
    ln -sf /data/submarines Submarines/Added
fi

if [[ ! -z ${LANGUAGE} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//config/@language' -v "${LANGUAGE}" config_player.xml
fi

if [[ ! -z ${SERVER_NAME} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@name' -v "${SERVER_NAME}" serversettings.xml
fi
if [[ ! -z ${MAX_PLAYERS} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@MaxPlayers' -v ${MAX_PLAYERS} serversettings.xml
fi
if [[ ! -z ${GAME_PORT} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@port' -v ${GAME_PORT} serversettings.xml
fi
if [[ ! -z ${QUERY_PORT} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@queryport' -v ${QUERY_PORT} serversettings.xml
fi
if [[ ! -z ${PASSWORD} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@password' -v "${PASSWORD}" serversettings.xml
fi
if [[ ! -z ${IS_PUBLIC} ]];then
    xmlstarlet edit --pf --ps --inplace --update '//serversettings/@IsPublic' -v ${IS_PUBLIC} serversettings.xml
fi

if [[ ! -z ${OWNER_STEAMNAME} ]];then
    xmlstarlet edit --pf --ps --inplace\
        --var OWNER_STEAMNAME "'$OWNER_STEAMNAME'"\
        --var OWNER_STEAMID "'$OWNER_STEAMID'"\
        --delete '//ClientPermissions/Client[not(@name)]'\
        --delete '//ClientPermissions/Client[@name=$OWNER_STEAMNAME]'\
        --subnode '//ClientPermissions' -t elem -n Client\
        --insert '//ClientPermissions/Client[not(@name)]' -t attr -n name -v "${OWNER_STEAMNAME}"\
        --insert '//ClientPermissions/Client[@name=$OWNER_STEAMNAME]' -t attr -n steamid -v ${OWNER_STEAMID}\
        --insert '//ClientPermissions/Client[@name=$OWNER_STEAMNAME]' -t attr -n permissions -v All\
        Data/clientpermissions.xml
fi

export LD_LIBRARY_PATH=/opt/barotrauma/linux64:$LD_LIBRARY_PATH

exec $@