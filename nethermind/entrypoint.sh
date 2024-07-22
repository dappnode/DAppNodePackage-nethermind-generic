#!/bin/sh

SUPPORTED_NETWORKS="holesky mainnet gnosis"

# shellcheck disable=SC1091
. /etc/profile

JWT_PATH=$(get_jwt_path "${NETWORK}" "${SUPPORTED_NETWORKS}" "${SECURITY_PATH}")

post_jwt_to_dappmanager "${JWT_PATH}"

echo "[INFO - entrypoint] Starting Nethermind client for network: ${NETWORK}"

# shellcheck disable=SC2086
exec /nethermind/nethermind \
  --config "${NETWORK}" \
  --JsonRpc.JwtSecretFile="${JWT_PATH}" \
  --Network.DiscoveryPort="${P2P_PORT}" \
  --Network.P2PPort="${P2P_PORT}" ${EXTRA_OPTS}
