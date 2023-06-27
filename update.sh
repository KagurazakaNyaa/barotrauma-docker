#!/bin/bash
version=$(curl --silent "https://api.steamcmd.net/v1/info/1026340" | jq '.data."1026340".depots.branches.public.buildid' -r)
currentversion=$(cat currentversion)
echo "currentversion:$currentversion version:$version"
if [[ -z "${version}" ]]; then
    exit
fi
echo $version > currentversion
if [[ "$currentversion" == "$version" ]]; then
    exit
fi
git config user.name github-actions
git config user.email github-actions@github.com
git add currentversion
git commit -a -m "Auto Update Barotrauma to buildid: "$version
git tag -f latest
git push
git push origin --tags -f
