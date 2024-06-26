ARG UPSTREAM_VERSION
ARG NETWORK

FROM nethermind/nethermind:${UPSTREAM_VERSION}

RUN apt-get update && apt-get install -y curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NETHERMIND_JSONRPCCONFIG_ENABLED=true \
    NETHERMIND_INITCONFIG_BASEDBPATH=/data \
    NETHERMIND_INITCONFIG_LOGDIRECTORY=/data/logs \
    NETHERMIND_HEALTHCHECKSCONFIG_ENABLED=true \
    NETWORK=${NETWORK}

COPY /security /security
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]