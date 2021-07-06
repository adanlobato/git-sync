#!/bin/bash

git config --global url."https://${GIT_SYNC_GITHUB_TOKEN}@github.com/".insteadOf git@github.com:
  
pull() {
    git -C ${GIT_SYNC_DEST} pull --recurse-submodules
}
  
clone() {
    git clone git@github.com:${GIT_SYNC_ORG}/${GIT_SYNC_REPO}.git --recurse-submodules --depth=1 --shallow-submodules ${GIT_SYNC_DEST}
}

while : ; do
    printf "» ($(date +%X)) Syncing...\n"

    pull || clone
   
    if [ $? -eq 0 ]; then
        printf "✔ ($(date +%X)) ${GIT_SYNC_ORG}/${GIT_SYNC_REPO} Successfully synced\n\n"
    else
        printf "✘ ($(date +%X)) Something went wrong...\n\n"
    fi
    
    sleep ${GIT_SYNC_INTERVAL}
done