FROM bitnami/git

WORKDIR /git-sync

COPY . .

ENTRYPOINT /git-sync/git-sync.sh