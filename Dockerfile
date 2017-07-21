FROM ubuntu:12.04
MAINTAINER John Kirkham <jakirkham@gmail.com>


RUN apt-get update -y && \
    apt-get clean

ADD gridengine /usr/share/gridengine
RUN /usr/share/gridengine/install_ge.sh

ENV SGE_CONFIG_DIR=/usr/share/gridengine \
    SGE_ROOT=/var/lib/gridengine \
    SGE_CELL=default \
    DRMAA_LIBRARY_PATH=/usr/lib/libdrmaa.so.1.0

ADD docker /usr/share/docker
RUN /usr/share/docker/install_tini.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/share/docker/entrypoint.sh" ]
CMD [ "/bin/bash" ]
