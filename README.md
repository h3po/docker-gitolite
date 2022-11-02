# docker-gitolite
gitolite service based on debian:stable-slim

### Building
```bash
#get the latest gitolite tag
GITOLITE_VERSION="$(curl -s 'https://api.github.com/repos/sitaramc/gitolite/tags' | jq -r .[0].name)"
docker build --build-arg GITOLITE_VERSION="$GITOLITE_VERSION" --tag gitolite:"$GITOLITE_VERSION" --tag gitolite:latest .
```

### Usage
```bash
docker run -p 22:2222 \
-v gitolite:/var/lib/gitolite \
-v $HOME/.ssh/id_rsa.pub:/admin.pub \
-e PK_PATH=/admin.pub \
gitolite
```
