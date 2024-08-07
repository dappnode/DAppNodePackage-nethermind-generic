ARG UPSTREAM_VERSION

FROM nethermind/nethermind:${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT
ARG STAKER_SCRIPTS_VERSION
ARG DATA_DIR

ENV NETHERMIND_JSONRPCCONFIG_ENABLED=true \
    NETHERMIND_INITCONFIG_BASEDBPATH=${DATA_DIR} \
    NETHERMIND_INITCONFIG_LOGDIRECTORY=${DATA_DIR}/logs \
    NETHERMIND_HEALTHCHECKSCONFIG_ENABLED=true \
    P2P_PORT=${P2P_PORT} \
    JWT_PATH=/jwtsecret.hex \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/execution_tools.sh /etc/profile.d/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt-get update && apt-get --yes install curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/execution_tools.sh

# This env changes the variant
# Placed at the end to regenerate the least amount of layers
ENV NETWORK=${NETWORK}

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]