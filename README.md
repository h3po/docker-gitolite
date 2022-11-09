# docker-gitolite
gitolite service based on debian:stable-slim

### Usage
Persistent data is stored in `/var/lib/gitolite`. If the directory is empty, the start.sh script will run `gitolite setup` which then creates your gitolite-admin repository. You need to temporarily mount your ssh public key into the container and point the `PK_PATH` environment variable to it so gitolite cat setup your user for access to the admin repository.

first run:
```bash
#copy your ssh public key somewhere and make it readable by gitolite inside the container
cp $HOME/.ssh/id_rsa.pub .
chown 196:196 ./id_rsa.pub

#start the container once with this key mounted
docker run -p 22:2222 \
-v gitolite:/var/lib/gitolite \
-v $(pwd)/id_rsa.pub:/admin.pub \
-e PK_PATH=/admin.pub \
--name gitolite --rm -it
ghcr.io/h3po/gitolite

#cleanup
rm ./id_rsa.pub
```

subsequent runs:
```bash
docker run -p 22:2222 \
-v gitolite:/var/lib/gitolite \
ghcr.io/h3po/gitolite
```

### Building locally
```bash
#get the latest gitolite tag
GITOLITE_VERSION="$(curl -s 'https://api.github.com/repos/sitaramc/gitolite/tags' | jq -r .[0].name)"

docker build --build-arg GITOLITE_VERSION="$GITOLITE_VERSION" --tag gitolite:"$GITOLITE_VERSION" --tag gitolite:latest .
```
