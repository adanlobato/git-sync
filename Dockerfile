FROM bitnami/git

WORKDIR /code

COPY . .

ENTRYPOINT /code/git-sync.sh