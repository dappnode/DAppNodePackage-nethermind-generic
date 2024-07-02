ARG UPSTREAM_VERSION

FROM nethermind/nethermind:${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT
ARG STAKER_SCRIPTS_VERSION

COPY /security /security
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt-get update && apt-get install -y curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NETHERMIND_JSONRPCCONFIG_ENABLED=true \
    NETHERMIND_INITCONFIG_BASEDBPATH=/data \
    NETHERMIND_INITCONFIG_LOGDIRECTORY=/data/logs \
    NETHERMIND_HEALTHCHECKSCONFIG_ENABLED=true \
    NETWORK=${NETWORK} \
    P2P_PORT=${P2P_PORT} \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/execution_tools.sh /etc/profile.d/

RUN chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/execution_tools.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]