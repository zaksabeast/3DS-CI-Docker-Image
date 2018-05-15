# 3DS Docker
_An updated development environment for the Nintendo 3DS_

## Goals
- Provide an automated way to setup a 3DS dev environment
- Provide an easy way to compile 3DS homebrew locally
- Provide a solution for continuous integration
- Provide the latest libraries by compiling from source

## Building image
```
docker build -t 3dsci .
```

## Running image
```
docker run -it 3dsci /bin/bash
```

## Build project in current directory
```
docker run -it -v "$(pwd)":/app 3dsci make
```

## 3dsmake command

Linux:
```
echo alias 3dsmake=\'docker run -it -v '"$(pwd)"':/app 3dsci make\' >> ~/.bashrc
source ~/.bashrc
```

Mac:
```
echo alias 3dsmake=\'docker run -it -v '"$(pwd)"':/app 3dsci make\' >> ~/.bash_profile
source ~/.bash_profile
```

Usage:
```
cd <3DS homebrew project>
3dsmake clean
3dsmake
```

## What does this Docker image have?
- devkitARM
- makerom
- firmtool
- libctru
- armips
- bannertool
- zlib (from 3ds_portlibs)
- mbedtls-apache (from 3ds_portlibs)
- curl (from 3ds_portlibs)
