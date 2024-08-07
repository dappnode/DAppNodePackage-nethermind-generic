#!/bin/sh

# shellcheck disable=SC1091
. /etc/profile

JWT_SECRET=$(get_jwt_secret_by_network "${NETWORK}")
echo "${JWT_SECRET}" >"${JWT_PATH}"

post_jwt_to_dappmanager "${JWT_PATH}"

echo "[INFO - entrypoint] Starting Nethermind client for network: ${NETWORK}"

# shellcheck disable=SC2086
exec /nethermind/nethermind \
  --config "${NETWORK}" \
  --JsonRpc.JwtSecretFile="${JWT_PATH}" \
  --Network.DiscoveryPort="${P2P_PORT}" \
  --Network.P2PPort="${P2P_PORT}" ${EXTRA_OPTS}
