FROM ubuntu:latest

RUN useradd -ms /bin/bash overviewer-mc

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-pillow \
    python3-dev \
    python3-numpy \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /overviewer
RUN git clone --progress --verbose https://github.com/GregoryAM-SP/The-Minecraft-Overviewer.git .

# https://mcversions.net/download/1.20.1
ARG MINECRAFT_VERSION=1.20.1
ADD https://piston-data.mojang.com/v1/objects/0c3ec587af28e5a785c0b4a7b8a30f9a8f78f838/client.jar /home/overviewer-mc/.minecraft/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar
RUN chmod 775 /home/overviewer-mc/.minecraft/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar

RUN python3 setup.py build

VOLUME [ "/tmp/server", "/tmp/export" ]

USER overviewer-mc

ENTRYPOINT [ "/overviewer/overviewer.py", "/tmp/server/world", "/tmp/export"]