#!/bin/sh

SUPPORTED_NETWORKS="holesky mainnet gnosis"

# shellcheck disable=SC1091
. /etc/profile

run_client() {
  # shellcheck disable=SC2086
  exec /nethermind/nethermind \
    --config "${NETWORK}" \
    --JsonRpc.JwtSecretFile="${JWT_PATH}" \
    --Network.DiscoveryPort="${P2P_PORT}" \
    --Network.P2PPort="${P2P_PORT}" ${EXTRA_OPTS}
}

set_execution_config_by_network "${SUPPORTED_NETWORKS}"
post_jwt_to_dappmanager
run_client
