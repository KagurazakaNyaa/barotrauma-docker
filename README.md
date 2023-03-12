# barotrauma-docker

[![Check Update](https://github.com/KagurazakaNyaa/barotrauma-docker/actions/workflows/update.yml/badge.svg)](https://github.com/KagurazakaNyaa/barotrauma-docker/actions/workflows/update.yml)
[![Build Docker Image](https://github.com/KagurazakaNyaa/barotrauma-docker/actions/workflows/docker.yml/badge.svg)](https://github.com/KagurazakaNyaa/barotrauma-docker/actions/workflows/docker.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/kagurazakanyaa/barotrauma)
![Docker Stars](https://img.shields.io/docker/stars/kagurazakanyaa/barotrauma)
![Image Size](https://img.shields.io/docker/image-size/kagurazakanyaa/barotrauma/latest)

## Environments

| Variable        | Describe                                                                     | Default Values | Allowed Values |
|-----------------|------------------------------------------------------------------------------|----------------|----------------|
| OWNER_STEAMNAME | Steam display name for server admin                                          |                | String         |
| OWNER_STEAMI    | SteamID of the server administrator                                          |                | String         |
| IS_PUBLIC       | Whether the server should be listed in the in-game server browser            | false          | true/false     |
| SERVER_NAME     | Name of the server                                                           | Server         | String         |
| PASSWORD        | Password to connect to the server                                            |                | String         |
| MAX_PLAYERS     | The maximum number of players allowed by the server at the same time         | 10             | 1-16           |
| GAME_PORT       | Game Port                                                                    | 27015          | 1024-65535     |
| QUERY_PORT      | Query Port                                                                   | 27016          | 1024-65535     |
| LANGUAGE        | The language used by the server, affecting item names and robot speech, etc. | English        | String         |
