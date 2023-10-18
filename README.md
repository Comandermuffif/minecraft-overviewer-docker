# Minecraft Mapper Docker Image

```console
$ docker build . -t mapper
```

```console
$ docker run --rm \
    -v /home/user/minecraft-create:/tmp/server:ro \
    -v /home/user/minecraft-create-mapped:/tmp/export:rw \
    mapper
```