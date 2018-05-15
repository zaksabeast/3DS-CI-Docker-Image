# Use minideb base
FROM bitnami/minideb

# Set Environment Variables
ENV WORKDIR /app
ENV DEVKITPRO /opt/devkitpro
ENV DEVKITARM ${DEVKITPRO}/devkitARM
ENV DEVTOOLS ${DEVKITPRO}/devtools
ENV PATH=${PATH}:${DEVKITARM}/bin:${DEVTOOLS}

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update \
  && apt install git curl bzip2 make python gcc python-pip cmake zip -y

# Install devkitARM
RUN mkdir -p ${DEVKITARM} ${DEVTOOLS} \
  && curl -L https://downloads.devkitpro.org/devkitARM_r47-x86_64-linux.tar.bz2 -o ${WORKDIR}/devkitARM.tar.bz2 \
  && tar xjC ${DEVKITPRO} -f ${WORKDIR}/devkitARM.tar.bz2 \
# Cleanup
  && rm -rf ${WORKDIR}/* ${DEVKITPRO}/examples

# Install makerom
RUN git clone https://github.com/profi200/Project_CTR.git ${WORKDIR}/Project_CTR \
  && cd ${WORKDIR}/Project_CTR/makerom \
  && make \
  && cp makerom ${DEVTOOLS} \
# Install firmtool
  && pip install cryptography \
  && pip install git+https://github.com/TuxSH/firmtool.git \
# Install latest libctru
  && git clone https://github.com/smealum/ctrulib.git ${WORKDIR}/ctrulib \
  && cd ${WORKDIR}/ctrulib/libctru \
  && make \
  && make install \
# Install armips
  && git clone --recursive https://github.com/Kingcom/armips.git ${WORKDIR}/armips \
  && cd ${WORKDIR}/armips \
  && cmake CMakeLists.txt \
  && make \
  && cp armips ${DEVTOOLS} \
# Install bannertool
  && git clone --recursive https://github.com/Steveice10/bannertool.git ${WORKDIR}/bannertool \
  && cd ${WORKDIR}/bannertool \
  && make \
  && cp ./output/linux-x86_64/bannertool ${DEVTOOLS} \
# Install 3dstool
  && curl -L https://github.com/dnasdw/3dstool/releases/download/v1.1.1/3dstool_linux_x86_64.tar.gz -o ${WORKDIR}/3dstool.tar.gz \
  && tar -xzf ${WORKDIR}/3dstool.tar.gz \
  && mv 3dstool ${DEVTOOLS} \
# Install 3ds_portlibs
  && git clone https://github.com/devkitPro/3ds_portlibs.git ${WORKDIR}/3ds_portlibs \
  && cd ${WORKDIR}/3ds_portlibs \
  && make zlib \
  && make install-zlib \
  && make mbedtls-apache \
  && make install-mbedtls-apache \
  && make curl \
  && make install \
# Install citro3d
  && git clone https://github.com/fincs/citro3d ${WORKDIR}/citro3d \
  && cd ${WORKDIR}/citro3d \
  && make \
  && make install \
# Install citro2d
  && git clone https://github.com/devkitPro/citro2d ${WORKDIR}/citro2d \
  && cd ${WORKDIR}/citro2d \
  && make \
  && make install \
# Cleanup
  && rm -rf ${WORKDIR}/*