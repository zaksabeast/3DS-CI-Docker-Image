# Use an official Python runtime as a base image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Setup dependencies
RUN apt-get update
RUN apt-get install libgmp3-dev zip git curl wget bzip2 build-essential cmake -y
RUN mkdir /app/bin

# Environment Variables
ENV DEVKITPRO /app/devkitpro
ENV DEVKITARM /app/devkitpro/devkitARM

# Install devkitARM
RUN curl -L https://raw.githubusercontent.com/devkitPro/installer/master/perl/devkitARMupdate.pl -o devkitARMupdate.pl
RUN chmod +x ./devkitARMupdate.pl
RUN ./devkitARMupdate.pl /app/devkitpro
RUN echo "export DEVKITPRO=/app/devkitpro" >> ~/.bashrc
RUN echo "export DEVKITARM=$DEVKITPRO/devkitARM" >> ~/.bashrc
RUN echo "export PATH=$PATH:$DEVKITARM/bin:/app/bin" >> ~/.bashrc

# Install makerom
RUN git clone https://github.com/profi200/Project_CTR.git
RUN cd /app/Project_CTR/makerom && make && cp makerom /app/bin/.

# Install firmtool
RUN pip install cryptography
RUN pip install git+https://github.com/TuxSH/firmtool.git

# Install latest libctru
RUN git clone https://github.com/smealum/ctrulib.git
RUN cd ctrulib/libctru && make && make install

# Install armips
RUN git clone --recursive https://github.com/Kingcom/armips.git
RUN cd armips && cmake CMakeLists.txt && make && cp armips /app/bin/.

# Install bannertool
RUN git clone --recursive https://github.com/Steveice10/bannertool.git
RUN cd bannertool && make && cp ./output/linux-x86_64/bannertool /app/bin/.

# Install 3dstool
RUN curl -L https://github.com/dnasdw/3dstool/releases/download/v1.1.1/3dstool_linux_x86_64.tar.gz -o 3dstool.tar.gz
RUN tar -xzf 3dstool.tar.gz && mv 3dstool /app/bin/.

# Install 3ds_portlibs
RUN git clone https://github.com/devkitPro/3ds_portlibs.git
RUN cd 3ds_portlibs && make zlib && make install-zlib && make mbedtls-apache && make install-mbedtls-apache && make curl && make install

# Cleanup
RUN rm *.tar.bz2 devkitARMupdate.pl 3dstool.tar.gz ignore_3dstool.txt ext_key.txt
RUN rm -rf Project_CTR ctrulib armips 3ds_portlibs bannertool
