# 3DS CI Docker Image
Docker image with a 3DS build environment

## What does this do?
This Docker image can be used to build 3DS homebrew.

Potential applications include:
- Continuous integration for 3DS homebrew
- Automated builds for a website or Discord channel
- Local builds without the need to setup a build environment

## Does this image have any benefits?
When tools are updated (libctru, devkitARM, etc.), rebuild this Docker image and it'll build the latest tools (with the exception of 3dstool)

It's easily deployable to the cloud and easily useable locally.

Used in conjunction with source control, nightly/experimental builds are simple to automate.

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
