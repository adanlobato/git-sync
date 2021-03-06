#!/bin/bash

git config --global url."https://${GIT_SYNC_GITHUB_TOKEN}@github.com/".insteadOf git@github.com:
git config --global url."https://${GIT_SYNC_GITHUB_TOKEN}@github.com/".insteadOf https://github.com/
  
pull() {
    git -C ${GIT_SYNC_DEST} pull --recurse-submodules
}
  
clone() {
    git clone ${GIT_SYNC_REPO} --branch ${GIT_SYNC_BRANCH:-develop} --recurse-submodules --depth=1 --shallow-submodules ${GIT_SYNC_DEST}
}

while : ; do
    printf "» ($(date +%X)) Syncing...\n"

    pull || clone
   
    if [ $? -eq 0 ]; then
        printf "✔ ($(date +%X)) ${GIT_SYNC_REPO} Successfully synced\n\n"
    else
        printf "✘ ($(date +%X)) Something went wrong...\n\n"
    fi
    
    if [ "${GIT_SYNC_ONE_TIME}" = true ]; then
        exit 0
    fi
    
    sleep ${GIT_SYNC_INTERVAL}
done
