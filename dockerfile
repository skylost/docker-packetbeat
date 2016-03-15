# Usage: FROM [image name]
FROM debian

# Usage: MAINTAINER [name]
MAINTAINER weezhard

# Variables
ENV PACKETBEAT_VERSION 1.1.2

# Install wget
RUN apt-get update && \
    apt-get install -y -q wget

# Install kibana
RUN wget -q https://download.elastic.co/beats/packetbeat/packetbeat-$PACKETBEAT_VERSION-x86_64.tar.gz -O /opt/packetbeat.tar.gz && \
    cd /opt && tar -xzvf packetbeat.tar.gz && \
    mv /opt/packetbeat-$PACKETBEAT_VERSION-x86_64 /opt/packetbeat

# Clean apt
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /opt/packetbeat.tar.gz

COPY conf/packetbeat.yml /opt/packetbeat/packetbeat.yml

ENTRYPOINT ["/opt/packetbeat"]
