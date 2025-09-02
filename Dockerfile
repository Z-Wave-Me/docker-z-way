FROM debian:bullseye

WORKDIR /opt/z-way-server

ENV DEBIAN_FRONTEND=noninteractive

# Block zbw key request
RUN mkdir -p /etc/zbw/flags && touch /etc/zbw/flags/no_connection

# Install dependencies
RUN apt-get update && \
    apt-get install -qqy --no-install-recommends \
    ca-certificates curl wget procps gpg iproute2 \
    openssh-client openssh-server sudo logrotate && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 🔑 Add updated Z-Wave.Me repo key
RUN curl -fsSL https://repo.z-wave.me/z-way/raspbian/Release.key | gpg --dearmor -o /usr/share/keyrings/z-way.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/z-way.gpg] https://repo.z-wave.me/z-way/raspbian bullseye main" > /etc/apt/sources.list.d/z-way.list

# Install z-way-server
RUN wget -q -O - https://storage.z-wave.me/Z-Way-Install | bash -e && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -f /opt/z-way-server/automation/storage/*

# Unblock zbw
RUN rm /etc/zbw/flags/no_connection
RUN echo "zbox" > /etc/z-way/box_type

COPY rootfs/ /

# Add the initialization script
RUN chmod +x /opt/z-way-server/run.sh

EXPOSE 8083

CMD ["/opt/z-way-server/run.sh"]
